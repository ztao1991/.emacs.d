;;; ein-cell-edit.el --- Notebook cell editing

;; Copyright (C) 2016 John M. Miller

;; Author: John Miller <millejoh at mac.com>

;; This file is NOT part of GNU Emacs.

;; ein-cell-edit.el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; ein-cell-edit.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with ein-worksheet.el.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This code inspired by borrowing from org-src.el.

;;; Code:
(require 'ein-cell)

(defvar ein:src--cell nil)
(defvar ein:src--ws nil)
(defvar ein:src--allow-write-back t)
(defvar ein:src--overlay nil)

(defvar ein:edit-cell-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-c'" 'ein:edit-cell-exit)
    (define-key map "\C-c\C-k" 'ein:edit-cell-abort)
    (define-key map "\C-c\C-c" 'ein:edit-cell-save-and-execute)
    (define-key map "\C-x\C-s" 'ein:edit-cell-save)
    (define-key map "\C-c\C-x" 'ein:edit-cell-view-traceback)
    map))

(define-minor-mode ein:edit-cell-mode
  "Minor mode for language major mode buffers generated by EIN.
This minor mode is turned on when editing a source code snippet with \\[ein:edit-cell-contents]

\\{ein:edit-cell-mode-map}

."
  nil " EinCell" nil
  (set (make-local-variable 'header-line-format)
       (substitute-command-keys
        "Edit, execute with \\[ein:edit-cell-execute] then exit with \\[ein:edit-cell-exit] \
or abort with \\[ein:edit-cell-abort]"))
  ;; Possibly activate various auto-save features (for the edit buffer
  ;; or the source buffer).
  ;; (when org-edit-src-turn-on-auto-save
  ;;   (setq buffer-auto-save-file-name
  ;;   (concat (make-temp-name "org-src-")
  ;;    (format-time-string "-%Y-%d-%m")
  ;;    ".txt")))
  ;; (unless (or org-src--auto-save-timer (zerop org-edit-src-auto-save-idle-delay))
  ;;   (setq org-src--auto-save-timer
  ;;         (run-with-idle-timer
  ;;          org-edit-src-auto-save-idle-delay t
  ;;          (lambda ()
  ;;            (save-excursion
  ;;              (let (edit-flag)
  ;;                (dolist (b (buffer-list))
  ;;                  (with-current-buffer b
  ;;                    (when (org-src-edit-buffer-p)
  ;;                      (unless edit-flag (setq edit-flag t))
  ;;                      (when (buffer-modified-p) (org-edit-src-save)))))
  ;;                (unless edit-flag
  ;;                  (cancel-timer org-src--auto-save-timer)
  ;;                  (setq org-src--auto-save-timer nil))))))))
  )

(defun ein:cell-configure-edit-buffer ()
  (when (bound-and-true-p org-src--from-org-mode)
    (add-hook 'kill-buffer-hook #'org-src--remove-overlay nil 'local)
    (if (bound-and-true-p org-src--allow-write-back)
        (progn
          (setq buffer-offer-save t)
          (setq buffer-file-name
                (concat (buffer-file-name (marker-buffer org-src--beg-marker))
                        "[" (buffer-name) "]"))
          (setq write-contents-functions '(ein:edit-cell-save)))
      (setq buffer-read-only t))))

(defun ein:edit-cell-view-traceback ()
  "Jump to traceback, if there is one, for current edit."
  (interactive)
  (let ((buf (current-buffer))
        (cell ein:src--cell))
    (with-current-buffer (ein:worksheet--get-buffer ein:src--ws)
      (ein:cell-goto cell)
      (ein:tb-show))))

(defun ein:edit-cell-save-and-execute ()
  "Save, then execute the countents of the EIN source edit buffer
and place results (if any) in output of original notebook cell."
  (interactive)
  (ein:edit-cell-save)
  (when (and (slot-exists-p ein:src--cell 'kernel)
             (slot-boundp ein:src--cell 'kernel))
    (ein:cell-execute-internal ein:src--cell
                               (slot-value ein:src--cell 'kernel)
                               (buffer-string)
                               :silent nil)))

(defun ein:edit-cell-save ()
  "Save contents of EIN source edit buffer back to original notebook
cell."
  (interactive)
  (set-buffer-modified-p nil)
  (let* ((edited-code (buffer-string))
         (cell ein:src--cell)
         (overlay ein:src--overlay)
         (read-only (overlay-get overlay 'modification-hooks)))
    (overlay-put overlay 'modification-hooks nil)
    (overlay-put overlay 'insert-in-front-hooks nil)
    (overlay-put overlay 'insert-behind-hooks nil)
    (with-current-buffer (ein:worksheet--get-buffer ein:src--ws)
        (ein:cell-set-text cell edited-code))
    ;;(setf (slot-value ein:src--cell 'input) edited-code)
    (overlay-put overlay 'modification-hooks read-only)
    (overlay-put overlay 'insert-in-front-hooks read-only)
    (overlay-put overlay 'insert-behind-hooks read-only)))


(defun ein:edit-cell-exit ()
  "Close the EIN source edit buffer, saving contents back to the
original notebook cell, unless being called via
`ein:edit-cell-abort'."
  (interactive)
  (let ((edit-buffer (current-buffer))
        (ws ein:src--ws)
        (cell ein:src--cell))
    (ein:remove-overlay)
    (when ein:src--allow-write-back
      (ein:edit-cell-save))
    (kill-buffer edit-buffer)
    (switch-to-buffer-other-window (ein:worksheet--get-buffer ws))
    (ein:cell-goto cell)))

(defun ein:edit-cell-abort ()
  "Abort editing the current cell, contents will revert to
previous value."
  (interactive)
  (let (ein:src--allow-write-back) (ein:edit-cell-exit)))

(defun ein:construct-cell-edit-buffer-name (bufname cid cell-type)
  (concat "*EIN Src " bufname "[ " cid "/" cell-type " ]*" ))

(defun ein:get-mode-for-kernel (kernelspec)
  (if (null kernelspec)
      'python ;; FIXME
    (cond ((string-match-p "python" (ein:get-kernelspec-language kernelspec)) 'python)
          (t 'python))))

(defun ein:edit-src-continue (e)
  (interactive "e")
  (mouse-set-point e)
  (let ((buf (get-char-property (point) 'edit-buffer)))
    (if buf (org-src-switch-to-buffer buf 'continue)
      (user-error "No sub-editing buffer for area at point"))))

(defun ein:make-source-overlay (beg end edit-buffer)
  "Create overlay between BEG and END positions and return it.
EDIT-BUFFER is the buffer currently editing area between BEG and
END."
  (let ((overlay (make-overlay beg end)))
    (overlay-put overlay 'face 'secondary-selection)
    (overlay-put overlay 'edit-buffer edit-buffer)
    (overlay-put overlay 'help-echo
		 "Click with mouse-1 to switch to buffer editing this segment")
    (overlay-put overlay 'face 'secondary-selection)
    (overlay-put overlay 'keymap
		 (let ((map (make-sparse-keymap)))
		   (define-key map [mouse-1] 'ein:edit-src-continue)
		   map))
    (let ((read-only
           (list
            (lambda (&rest _)
              (user-error
               "Cannot modify an area being edited in a dedicated buffer")))))
      (overlay-put overlay 'modification-hooks read-only)
      (overlay-put overlay 'insert-in-front-hooks read-only)
      (overlay-put overlay 'insert-behind-hooks read-only))
    overlay))

(defun ein:remove-overlay ()
  "Remove overlay from current source buffer."
  (when (overlayp ein:src--overlay) (delete-overlay ein:src--overlay)))

(defcustom ein:raw-cell-default-edit-mode 'LaTeX-mode
  "The major mode to use when editing a cell of type 'Raw' in the
  dedicated edit buffer. By default we use LaTeX-mode."
  :type 'symbol
  :group 'ein)

(defun ein:edit-cell-contents ()
  "Edit the contents of the current cell in a buffer using an
appropriate language major mode. Functionality is very similar to
`org-edit-special'."
  (interactive)
  (let* ((cell (or (ein:worksheet-get-current-cell)
                   (error "Must be called from inside an EIN worksheet cell.")))
         (nb (ein:notebook--get-nb-or-error))
         (ws (ein:worksheet--get-ws-or-error))
         (type (slot-value cell 'cell-type))
         (name (ein:construct-cell-edit-buffer-name (buffer-name) (ein:cell-id cell) type)))
    (ein:aif (get-buffer name)
        (switch-to-buffer-other-window it)
      (ein:create-edit-cell-buffer name cell nb ws))))

(defun ein:edit-cell-detect-type (contents notebook &optional raw-cell-p)
  (if (string-match "^%%\\(.*\\)" contents)
      (ein:case-equal (match-string 1 contents)
        (("html" "HTML") (html-mode))
        (("latex" "LATEX") (LaTeX-mode))
        (("ruby") (ruby-mode))
        (("sh" "bash") (sh-mode))
        (("javascript" "js") (javascript-mode))
        (t (funcall ein:raw-cell-default-edit-mode)))
    (if raw-cell-p
        (funcall ein:raw-cell-default-edit-mode)
      (case (ein:get-mode-for-kernel (ein:$notebook-kernelspec notebook))
        (python (python-mode))))))

(defun ein:create-edit-cell-buffer (name cell notebook worksheet)
  (let* ((contents (ein:cell-get-text cell))
         (type (slot-value cell 'cell-type))
         (buffer (generate-new-buffer-name name))
         (overlay (ein:make-source-overlay (ein:cell-input-pos-min cell)
                                           (ein:cell-input-pos-max cell)
                                           buffer)))
    (switch-to-buffer-other-window buffer)
    (insert contents)
    (remove-text-properties (point-min) (point-max)
                            '(display nil invisible nil intangible nil))
    (set-buffer-modified-p nil)
    (setq buffer-file-name buffer) ;; Breaks anaconda-mode without this special fix.

    (condition-case e
        (ein:case-equal type
          (("markdown") (markdown-mode))
          (("raw") (ein:edit-cell-detect-type contents notebook t))
          (("code") (ein:edit-cell-detect-type contents notebook)))
      (error (message "Language mode `%s' fails with: %S"
                      type (nth 1 e))))
    (set (make-local-variable 'ein:src--overlay) overlay)
    (set (make-local-variable 'ein:src--cell) cell)
    (set (make-local-variable 'ein:src--ws) worksheet)
    (set (make-local-variable 'ein:src--allow-write-back) t)
    (ein:edit-cell-mode)))

(provide 'ein-cell-edit)
