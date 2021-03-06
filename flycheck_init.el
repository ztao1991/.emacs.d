;;-------------------------------------------------------
;;startup
;;-------------------------------------------------------

;; (define-key emacs-lisp-mode-map (kbd "C-x C-r") 'eval-region)
;; (define-key lisp-interaction-mode-map (kbd "C-x C-r") 'eval-region)
;; (define-key org-mode-map (kbd "<tab>") 'org-cycle)
;;(server-start)
;;(desktop-save-mode) 
;; (defun frame-setting ()
;;   (set-default-font "Monaco-12")
;;   (set-fontset-font "fontset-default" 'han '("PingFang SC"))
;;   (set-background-color "ivory")
;;   (set-cursor-color "red")
;;   (set-mouse-color "goldenrod")
 ;;   (set-foreground-color "black")
;;   )

;;(add-to-list 'default-frame-alist '(tty-color-mode  . -1))

;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions
;; 	      (lambda (frame)
;; 		(with-selected-frame frame
;; 		  (frame-setting))))
;;   (frame-setting))

(setq frame-title-format
      (list '(:eval (projectile-project-name)) 
            "(●—●) I'm Here @ "
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;(set-fontset-font "fontset-default" 'gb18030' ("Microsoft YaHei" . "unicode-bmp"))

(setq initial-scratch-message "")
(defun display-startup-echo-area-message ()
  (message "Just Type For Fun Or Hacking The Write."))

(setq x-select-enable-clipboard t)

;;(setq visible-bell 1)
;; Disable the splash screen (to enable it agin, replace the t with 0)
;;(setq inhibit-splash-screen t)

(tool-bar-mode 0)  
(menu-bar-mode 0)  
(scroll-bar-mode 0)  
;;(set-scroll-bar-mode 'right)
(visual-line-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'default-frame-alist '(height . 20))
(add-to-list 'default-frame-alist '(width . 56))

;;(setq default-directory "C:/Users/zhangtao/Dropbox/")
;;(cd "~/emacs/home/")  
;;(setq default-directory "~/Dropbox/")

(setq-default fill-column 80)

;;eshell
;;(setq shell-file-name "cmdproxy")
(setq shell-file-name "/bin/zsh")

(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;; (defun command-shell ()
;;   "opens a shell which can run programs as if run from cmd.exe from Windows"
;;   (interactive)
;;   (let ((explicit-shell-file-name "cmdproxy")
;;     (shell-file-name "cmdproxy") (comint-dynamic-complete t))
;;     (shell)))

(global-set-key [f2] 'eshell)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))
(setq eshell-cmpl-cycle-completions nil)

;; -*- mode: org -*-
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;;Browser
(setq gnus-button-url 'browse-url-generic
      browse-url-generic-program "chromium"
      browse-url-browser-function gnus-button-url)

;;(setq line-spacing '0.20)
(setq-default line-spacing 2)

(global-visual-line-mode 1)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(set-fringe-mode '(0 . 0))

;;(setq-default major-mode 'org-mode)
(eval-after-load "linum"
  '(set-face-attribute 'linum nil :height 100))

;;(setq default-justificatio 'full)
;;(defalias 'ar #'align-regexp)

;;(transient-mark-mode 1)

(electric-pair-mode t) ;;括号补全
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
;;(setq show-paren-style 'expression) 

;; (require 'autopair)
;; (autopair-global-mode) 

;;cursor
;;(setq default-cursor-type 'bar)
;;(set-cursor-color "#ffffff")

(set-display-table-slot standard-display-table 'wrap ?\ ) 

;;---------------------------
;;SOME CHANGE FOR KEYBINGDING
;;---------------------------
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "C-c C-m") 'smex)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)
(global-set-key (kbd "C-c C-k") 'kill-region)


;;(global-unset-key (kbd "C-SPC"))  
;;(global-set-key (kbd "M-SPC") 'set-mark-command)

;;(defalias 'qrr 'query-replace-regexp) ;;define the alias

;;---------------------------
;;fonts
;;---------------------------
;;(add-to-list 'default-frame-alist '(font . "Consolas-10:antialias=true:autohinting=true" ))
;; (set-frame-font "Consolas-10")
;;(set-frame-font "-adobe-Source Code Pro-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
;;(set-frame-font "Source Code Pro 10")
;;(set-frame-font "Inconsolata-g-10")
(set-frame-font "Monaco-9")

(set-fontset-font "fontset-default" 'chinese-gbk "WenQuanYi Micro Hei Mono")
;; (set-fontset-font "fontset-default" 'han "Source Han Sans CN Regular")
(set-fontset-font "fontset-default" 'han '("-apple-.萍方-简-normal-normal-normal-*-34-*-*-*-*-0-iso10646-1"))
;;(set-fontset-font "fontset-default" 'han '("Hiragino Sans GB"))
;;(set-fontset-font "fontset-default" 'han "WenQuanYi Micro Hei Mono 12")

;;Fullscreen
;; (global-set-key [f11] 'my-fullscreen) 
;; (defun my-fullscreen ()
;;   (interactive)
;; (x-send-client-message
;;  nil 0 nil "_NET_WM_STATE" 32
;;  '(2 "_NET_WM_STATE_FULLSCREEN" 0))
;; )

(defun switch-full-screen (&optional ii)
  (interactive "p")
  (if (> ii 0)
      (shell-command "wmctrl -r :ACTIVE: -badd,fullscreen"))
  (if (< ii 0)
      (shell-command "wmctrl -r :ACTIVE: -bremove,fullscreen"))
  (if (equal ii 0)
      (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen")))

;; Use xsel to access the X clipboard apt install xsel
;; From https://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
(unless window-system
  (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
        (insert text)
        ;; Use primary the primary selection
        ;; mouse-select/middle-button-click
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--primary" "--input")))
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --primary --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output)))
    ;; Attach callbacks to hooks
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)))
;; Mimic Vim's set paste
;; From http://stackoverflow.com/questions/18691973/is-there-a-set-paste-option-in-emacs-to-paste-paste-from-external-clipboard
(defvar ttypaste-mode nil)
(add-to-list 'minor-mode-alist '(ttypaste-mode " Paste"))
(defun ttypaste-mode ()
  (interactive)
  (let ((buf (current-buffer))
        (ttypaste-mode t))
    (with-temp-buffer
      (let ((stay t)
            (text (current-buffer)))
        (redisplay)
        (while stay
          (let ((char (let ((inhibit-redisplay t)) (read-event nil t 0.1))))
            (unless char
              (with-current-buffer buf (insert-buffer-substring text))
              (erase-buffer)
              (redisplay)
              (setq char (read-event nil t)))
            (cond
             ((not (characterp char)) (setq stay nil))
             ((eq char ?\r) (insert ?\n))
             ((eq char ?\e)
              (if (sit-for 0.1 'nodisp) (setq stay nil) (insert ?\e)))
             (t (insert char)))))
        (insert-buffer-substring text)))))

;; Automatically set screen title
;; ref http://vim.wikia.com/wiki/Automatically_set_screen_title
;; FIXME: emacsclient in xterm will have problem if emacs daemon start in screen
;; (defun update-title ()
;;   (interactive)
;;   (if (getenv "STY")	; check whether in GNU screen
;; 	  (send-string-to-terminal (concat "\033k\033\134\033k" "Emacs("(buffer-name)")" "\033\134"))
;; 	(send-string-to-terminal (concat "\033]2; " "Emacs("(buffer-name)")" "\007"))))
;; (add-hook 'post-command-hook 'update-title)

;;bookmark
(setq bookmark-default-file "~/.emacs.d/.bookmarks.bmk")
(setq bookmark-save-flag 1)

;;----------------------------------------------------------------------------------
;;Plugin
;;----------------------------------------------------------------------------------

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;; ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
;;(package-refresh-contents)
(package-initialize)
;; (require 'cl-lib)
;; (require 'cl)

;----------------------
;Themes
;----------------------

;;color-themes
;; (add-to-list 'load-path "~/.emacs.d/elpa/color-theme-6.6.0/")
;; (require 'color-theme)
;; (color-theme-initialize)
;; ;; (color-theme-tangotango)
;; (color-theme-matrix)

;;solarized
;; (setq solarized-termcolors 256)
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/color-theme-solarized/")
;; (load-theme 'solarized t)

;; (add-hook 'after-make-frame-functions
;;           (lambda (frame)
;;             (let ((mode (if (display-graphic-p frame) 'light )))
;;               (set-frame-parameter frame 'background-mode mode)
;;               (set-terminal-parameter frame 'background-mode mode))
;;              (enable-theme 'solarized)))


;; (load-theme 'solarized t)
;; (set-frame-parameter nil 'background-mode 'dark)    
;; (enable-theme 'solarized)

;;colors
(setq cursor-type 'box)

;;(set-background-color "ivory")
;; (set-background-color "#ffffff")
;; (set-foreground-color "black")

(set-background-color "black")
(set-foreground-color "white")

(set-face-foreground 'isearch "orange red")
(set-face-background 'isearch "#ffff00")
(set-face-foreground 'lazy-highlight "black")
(set-face-background 'lazy-highlight "#ffff00")

(set-face-attribute 'region nil :background "#F0E68C" :foreground "black")

;;(setq frame-background-mode 'light)
;;(setq frame-background-mode 'dark)

(set-cursor-color "red")
(set-mouse-color "goldenrod")

;;zenburn
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load "~/.emacs.d/themes/color-theme-tomorrow.el")
;; (load "~/.emacs.d/themes/tomorrow-night-bright-theme.el")
;; ;;(load "~/.emacs.d/themes/ujelly-theme.el")
;; ;;(load "~/.emacs.d/themes/monokai-theme.el")

;; (load-theme 'zenburn t)
;; ;;(load-theme 'dracula t)
;; (set-cursor-color "red")

;;--------------------------
;;mode-line
;;--------------------------
;;(setq-default mode-line-format nil)

;; (setq-default mode-line-format
;; 	      (list
;; 	       ;; (propertize "[" 'face 'bold) 
;; 	       ;; '(:eval (propertize
;; 	       ;; 		(window-numbering-get-number-string)
;; 	       ;; 		'face
;; 	       ;; 		'bold))
;; 	       ;; (propertize "]" 'face 'bold) 

;; 	       '(:eval (propertize "%b " 'face 'bold
;; 	       			   'help-echo (buffer-file-name)))
;; 	       "                    "
;; 	       ;; "%-"
;; 	       (propertize "%02l,%02c" 'face 'bold) 

;; 	       "            "
;; 	       (propertize " %p/%I " 'face 'bold) ;; % above top
;; 	       "               "
;; 	       ;; '(:eval (propertize (codefalling//simplify-major-mode-name) 'face 'bold
;; 	       ;; 			   'help-echo buffer-file-coding-system))

;; 	       '(:eval (propertize "[%m]" 'face 'bold
;; 	       			   'help-echo buffer-file-coding-system))

;; 	       ;; '(:eval (propertize (if overwrite-mode "[Ovr]" "[Ins]")
;; 	       ;; 			   'face 'bold
;; 	       ;; 			   'help-echo (concat "Buffer is in "
;; 	       ;; 					      (if overwrite-mode "overwrite" "insert") " mode")))

;; 	       ;; ;; was this buffer modified since the last save?
;; 	       ;; '(:eval (when (buffer-modified-p)
;; 	       ;; 		 (concat ","  (propertize "Mod"
;; 	       ;; 					  'face 'font-lock-warning-face
;; 	       ;; 					  'help-echo "Buffer has been modified"))))

;; 	       ;; ;; is this buffer read-only?
;; 	       ;; '(:eval (when buffer-read-only
;; 	       ;; 		 (concat ","  (propertize "RO"
;; 	       ;; 					  'face 'bold
;; 	       ;; 					  'help-echo "Buffer is read-only"))))  

;; 	       ;; add the time, with the date and the emacs uptime in the tooltip
;; 	       ;; '(:eval (propertize (format-time-string "%H:%M")
;; 	       ;; 			   'help-echo
;; 	       ;; 			   (concat (format-time-string "%c; ")
;; 	       ;; 				   (emacs-uptime "Uptime:%hh"))))

;; 	       ;; " --"
;; 	       ;; i don't want to see minor-modes; but if you want, uncomment this:
;; 	       ;; minor-mode-alist  ;; list of minor modes
;; 	       "% " ;; fill with '-'
;; 	       ))


;;(set-face-attribute 'mode-line nil  :height 90)

;;---------------------------Vertical-border
;; (set-face-background 'vertical-border (face-background 'default))
;; (set-face-background 'vertical-border "gray") ;;default
;; ;;(set-face-background 'vertical-border "#284b54") ;;solarized
;; ;;(set-face-background 'vertical-border "gray37") ;;37-50 ;;zenburn
;; ;;(set-face-background 'vertical-border "gray15")

;; Reverse colors for the border to have nicer line  
(set-face-inverse-video-p 'vertical-border nil)
;; (set-face-foreground 'vertical-border (face-background 'vertical-border))

;; (set-face-foreground 'vertical-border "gray")
;; (set-face-background 'vertical-border "#FFFFFF")

;; (set-face-foreground 'vertical-border "gray42")
;; (set-face-background 'vertical-border "black")

(set-display-table-slot standard-display-table
                        'vertical-border 
                        (make-glyph-code ?│))

;;(set-face-background 'fringe "#809088")

;;smart-mode-line------------------------
;;(display-time-mode)
(require 'smart-mode-line)
;; (require 'powerline)
(setq sml/no-confirm-load-theme t)

;;(setq sml/theme 'dark)
;;(setq sml/theme 'light)
(setq sml/theme 'respectful)

;; (setq sml/theme 'powerline)
;; ;; (setq sml/theme 'light-powerline)
;; (setq powerline-arrow-shape 'curves)
;; (setq powerline-default-separator-dir '(right . left))
(setq sml/mode-width 'full)
(setq sml/name-width 20)


(add-to-list 'sml/hidden-modes " Wrap")
(add-to-list 'sml/hidden-modes " AcePY")
(add-to-list 'sml/hidden-modes " Helm")
(add-to-list 'sml/hidden-modes " Undo-Tree")
(add-to-list 'sml/hidden-modes " AC")
(add-to-list 'sml/hidden-modes " FlyC")
(add-to-list 'sml/hidden-modes " super-save")


(sml/setup)





;; (set-face-attribute 'mode-line nil
;;                     :foreground "#000000"
;;                     :background "#FFFFFF" ;;#FFFFFF
;;                     :box nil)
;; (set-face-attribute 'modeline-inactive nil
;;                     :foreground "#000000"
;;                     :background "#FFFFFF"
;;                     :box nil)

;; (set-face-attribute 'mode-line nil
;;                     :foreground "#32cd32"
;;                     :background "#000000" ;;#FFFFFF
;;                     :box nil)
;; (set-face-attribute 'modeline-inactive nil
;;                     :foreground "#32cd32"
;;                     :background "#000000"
;;                     :box nil)

;; (set-face-attribute 'mode-line nil
;;                     :box nil)
;; (set-face-attribute 'modeline-inactive nil
;;                     :box nil)


;;relative-number------------------------
;; (require 'linum-relative)
;;     (linum-on)
;; (add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
;; (add-hook 'prog-mode-hook 'line-number-mode t)
;; (add-hook 'prog-mode-hook 'column-number-mode t)

;; (setq
;;  linum-relative-current-symbol ""
;;  linum-relative-format "%3s "
;;  linum-delay t)

;; (set-face-attribute 'linum-relative-current-face nil
;;                     :weight 'extra-bold
;;                     :foreground nil
;;                     :background nil
;;                     :inherit '(hl-line default)))

;;file explore-----------------
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq-default neo-smart-open t)
(setq neo-theme (if (display-graphic-p) 'ascii))

;;Terminal------------------
(setq multi-term-program "/bin/zsh")
(setq system-uses-terminfo nil)

(add-hook 'term-mode-hook
          (lambda ()
            (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
            (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))

(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 0)))

(add-hook 'term-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)
            (autopair-mode -1)))

(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-y") 'term-paste)))

;; (add-hook 'term-mode-hook
;;               '(lambda ()
;;                  (term-set-escape-char ?\C-x)))

;;-----------------
;;Calendar
;;-----------------
(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-important-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-important-holidays)
(setq my-holidays '((holiday-fixed 2 14 "情人节") (holiday-fixed 9 10 "教师节") (holiday-float 6 0 3 "父亲节")
                    (holiday-lunar 1 1 "春节" 0) (holiday-lunar 1 15 "元宵节" 0) (holiday-solar-term "清明" "清明节") (holiday-lunar 5 5 "端午节" 0) (holiday-lunar 7 7 "七夕情人节" 0) (holiday-lunar 8 15 "中秋节" 0)
                    (holiday-lunar 12 23 "妈妈生日" 0) (holiday-lunar 5 5 "爸爸生日" 0) (holiday-lunar 10 17 "姐姐生日" 0) (holiday-lunar 10 18 "姐夫生日" 0) (holiday-fixed 10 29 "宝宝生日") ))
(setq calendar-holidays my-holidays)
;;(holiday-lunar 9 17 "宝宝生日" 0)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;;-----------------------
;;ido-mode
;;-----------------------
(require 'ido)
(ido-mode t)
(setq ido-file-extensions-order '(".org" ".txt" ))
(setq ido-use-filename-at-point 'guess)
(setq ido-file-extensions-order '(".txt" ".org" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf" "" t))

(defun ido-bookmark-jump (bname)
  "*Switch to bookmark interactively using `ido'."
  (interactive (list (ido-completing-read "Bookmark: " (bookmark-all-names) nil t)))
  (bookmark-jump bname))
(global-set-key (kbd "C-x r l") 'ido-bookmark-jump)
;;(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;;(setq ido-separator "\n")
(setq ido-enable-flex-matching t)
;;(setq max-mini-window-height 0.5)

;;(setq ido-use-virtual-buffers t)

;;keep a list of recently opened files                                                                      
;; (require 'recentf)
;; (setq recentf-auto-cleanup 'never)
;; (recentf-mode 1)
;; (setq-default recent-save-file "~/.emacs.d/recentf")

;; (defun ido-recentf-open ()
;;   "Use `ido-completing-read' to find a recent file."
;;   (interactive)
;;   (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;;       (message "Opening file...")
;;     (message "Aborting")))

;; (global-set-key (kbd "C-x C-r") 'ido-recentf-open)
;; (setq recentf-max-saved-items 150)

;---------------
;smex
;---------------
(add-to-list 'load-path "~/.emacs.d/elpa/smex/")
(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;---------------
;;undo-tree c-x u
;;---------------
(global-undo-tree-mode)

;;----------------
;;windows—switch
;;----------------

;; (global-set-key (kbd "M-p") 'ace-window)

;;fringer
;;(set-window-fringes (selected-window) 0 0 nil)

;; (custom-set-faces
;;   '(default ((t (:backgroun "black" :foreground "grey"))))
;;   '(fringe (( (:background "black")))))

;;smooth-scroll---------------------------------
;; (require 'smooth-scrolling)
;; (smooth-scrolling-mode 1)
;; (setq scroll-margin 5
;;       scroll-conservatively 9999
;;       scroll-step 1)


;;---------------------------------------------------------------------------------


;;-----------------------
;;Ag apt-get install silversearcher-ag
;;-----------------------
(require 'ag)
(setq ag-highlight-search t)
(setq ag-reuse-window 't)
(setq ag-reuse-buffers 't)

;;-----------------------
;;helm-mode Helm 作为前端使用 helm-swoop+helm-ag
;;-----------------------
(setq tramp-mode nil)
(setq ad-redefinition-action 'accept)
(require 'helm-config)
(require 'helm)
(helm-mode t)

(defadvice helm-display-mode-line (after undisplay-header activate) (setq header-line-format nil))
(defun helm-display-mode-line (source &optional force) (setq mode-line-format nil))

(setq helm-ff-transformer-show-only-basename nil
      helm-adaptive-history-file             "~/.emacs.d/helm-history.txt"
      helm-yank-symbol-first                 t
      helm-move-to-line-cycle-in-source      t
      helm-M-x-fuzzy-match                   t
      ;;      helm-recentf-fuzzy-match               t
      ;;      helm-ff-file-name-history-use-recentf  t
      helm-buffers-fuzzy-matching            t
      helm-ff-auto-update-initial-value      t)

;; (autoload 'helm-descbinds      "helm-descbinds" t)
;; (autoload 'helm-eshell-history "helm-eshell"    t)
;; (autoload 'helm-esh-pcomplete  "helm-eshell"    t)

;; (global-set-key (kbd "C-h a")    #'helm-apropos)
;; (global-set-key (kbd "C-h i")    #'helm-info-emacs)
;; (global-set-key (kbd "C-h b")    #'helm-descbinds)

;; (add-hook 'eshell-mode-hook
;;           #'(lambda ()
;;               (define-key eshell-mode-map (kbd "TAB")     #'helm-esh-pcomplete)
;;               (define-key eshell-mode-map (kbd "C-c C-l") #'helm-eshell-history)))

;; (global-set-key (kbd "C-x b")   #'helm-mini)
;; (global-set-key (kbd "C-x C-b") #'helm-buffers-list)
;; (global-set-key (kbd "M-x") #'helm-M-x)
;; (global-set-key (kbd "C-x C-f") #'helm-find-files)
;; (global-set-key (kbd "C-x C-r") #'helm-recentf)
;; (global-set-key (kbd "C-x r l") #'helm-filtered-bookmarks)

;;(global-set-key (kbd "M-y")     #'helm-show-kill-ring)

;; (global-set-key (kbd "M-i") 'helm-swoop)
;; (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

(global-set-key (kbd "M-s i")   #'helm-swoop)
(global-set-key (kbd "M-s /")   #'helm-multi-swoop)
(global-set-key (kbd "M-s /") 'helm-multi-swoop-all)
(global-set-key (kbd "M-s a")   #'helm-ag) ;;apt-get install silversearcher-ag

;;(global-set-key (kbd "C-s")   #'helm-swoop)
;; (global-set-key (kbd "M-s /")   #'helm-multi-swoop)
;; (global-set-key (kbd "M-s /") 'helm-multi-swoop-all)

(helm-autoresize-mode 1)

(setq save-place-file "~/.emacs.d/saveplace")
(save-place-mode 1) 


;;expand-region
;; (require 'expand-region)
;; (global-set-key (kbd "C-=") 'er/expand-region)
;;(global-set-key (kbd "C-c =") 'er/expand-region)

;--------------
;ace-jump
;--------------

;; (ace-isearch-mode +1)
;; (global-ace-isearch-mode +1)

(require 'ace-pinyin)
(setq ace-pinyin-use-avy nil)
(ace-pinyin-global-mode +1)

(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;;(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c SPC") nil))
;; When org-mode starts it (org-mode-map) overrides the ace-jump-mode.

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "\C-c SPC") 'ace-jump-mode)))



;;--------------
;;window-number
;;--------------
;; (require 'window-number)
;; (window-number-mode)

;; (require 'window-numbering)
;; (window-numbering-mode 1)
;; (setq window-numbering-assign-func
;;       (lambda () (when (equal (buffer-name) "*Calculator*") 9)))

;----------------
;yasnippet
;----------------

(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20161211.1918/")
(require 'yasnippet)
(yas-global-mode 1)
;;(setq yas-snippet-dirs "~/.emacs.d/snippets/")
;;(setq yas-snippet-dirs "~/.emacs.d/elpa/elpy-20161211.1045/snippets/")
;;(setq debug-on-error t)

;----------------
;auto-complete
;----------------

(add-to-list 'load-path "~/.emacs.d/elpa/popup-el/")
(require 'popup)

(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete/dict")
(ac-config-default)

(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

;;(add-to-list 'ac-modes 'org-mode)
(ac-set-trigger-key "TAB")


;; Require flycheck to be present
(require 'flycheck)
;; Force flycheck to always use c++11 support. We use
;; the clang language backend so this is set to clang
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-language-standard "c++11")))
;; Turn flycheck on everywhere
;;(global-flycheck-mode)

(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; Use flycheck-pyflakes for python. Seems to work a little better.
;; (require 'flycheck-pyflakes)

;;(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))

;;-------------------------
;;C++
;;-------------------------

;; ;; Load rtags and start the cmake-ide-setup process
;; (require 'rtags)
;; (require 'cmake-ide)
;; (cmake-ide-setup)
;; ;; Set cmake-ide-flags-c++ to use C++11
;; (setq cmake-ide-flags-c++ (append '("-std=c++11")))
;; ;; We want to be able to compile with a keyboard shortcut
;; (global-set-key (kbd "C-c m") 'cmake-ide-compile)

;; ;; Set rtags to enable completions and use the standard keybindings.
;; ;; A list of the keybindings can be found at:
;; ;; http://syamajala.github.io/c-ide.html
;; (setq rtags-autostart-diagnostics t)
;; (rtags-diagnostics)
;; (setq rtags-completions-enabled t)
;; (rtags-enable-standard-keybindings)

;; ;; clang-format can be triggered using C-M-tab
;; (require 'clang-format)
;; (global-set-key [C-M-tab] 'clang-format-region)
;; ;; Create clang-format file using google style
;; ;; clang-format -style=google -dump-config > .clang-format

;----------------
;python+c languge
;----------------

;;we should install ipython
;; (add-to-list 'load-path "~/.emacs.d/elpa/python-mode")
;; (require 'python-mode)

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys t)                      ; optional
;; (setq jedi:complete-on-dot t)                 ; optional

(elpy-enable)
;;(elpy-use-ipython)
(setq elpy-rpc-backend "jedi")

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq elpy-rpc-python-command "python3")
(setq python-shell-interpreter "python3")
;;(elpy-use-ipython "ipython3")

;;apt-get install ipython then M-x edit-abbrevs
;;(require 'ipython)
;;(setq-default py-shell-name "ipython")

;;pip install autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'tramp)
(add-to-list 'Info-default-directory-list "~/.emacs.d/tramp/info/")

;-----------------
;Java + Jdee
;-----------------

;; (add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;; (autoload 'jde-mode "jde" "JDE mode" t)
;; (setq auto-mode-alist
;;       (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;------------------
					;Html
					;------------------

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

;-----------------
;markdown-mode
;-----------------
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(autoload 'gfm-mode "gfm-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
;;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(setq markdown-enable-math t)

;-------------
;org-mode
;-------------

;; (require 'org-bullets)
;; (setq org-bullets-face-name (quote org-bullet-face))
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; (setq org-bullets-face-name (quote org-bullet-face))
;; ;; (set-face-attribute 'org-bullet-face 
;; ;;    t :foreground "burlywood" :weight 'normal :height 1.6)

;; ;; ;;(setq org-bullets-bullet-list '("◉" "◎" "⚫" "○" "►" "◇"))
;; ;; (setq org-bullets-bullet-list '("◉" "○" "◎" "●" "◯"))
;; ;; (setq org-ellipsis "↴");; ⤵ ▼, ↴, , ∞, ⬎, ⤷, ⤵ ≫

(setq org-startup-indented t)

;; (setq org-log-done 'time)
;;(setq org-log-done 'note)

;;(setq org-image-actual-width 600)
;;Auto Fill
(add-hook 'hack-local-variables-hook (lambda () (setq truncate-lines nil)))
(add-hook 'org-mode-hook   
          (lambda () (setq truncate-lines nil)))  
;; (add-hook 'org-mode-hook '(lambda () 
;; (setq visual-line-fringe-indicators t) 
;; (visual-line-mode) 
;; (if visual-line-mode 
;; (setq word-wrap nil)))) 

;;(add-hook 'org-mode-hook (lambda () (variable-pitch-mode t)))
;;org-mode display
(setq org-fontify-done-headline t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-done ((t (:foreground "Gray" :weight normal :strike-through t))))
 '(org-headline-done ((((class color) (min-colors 16) (background light)) (:foreground "Gray" :strike-through t))))
 '(term ((t (:background "white" :foreground "black")))))

(setq org-startup-indented t)
(setq org-hide-leading-stars t)

;;source code
(org-babel-do-load-languages
 'org-babel-load-languages
 '((lisp . t)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)))

(setq org-src-fontify-natively t)

;;Text
;; (add-to-list 'org-emphasis-alist
;;              '("*" (:foreground "red")
;;                ))
;; (setq org-emphasis-alist
;;       (cons '("*" '(:emphasis t :foreground "yellow"))
;;             (delete* "*" org-emphasis-alist :key 'car :test 'equal)))
(setq org-hide-emphasis-markers t)

;;org-capture

;;org-capture-extension

;; (load "~/.emacs.d/elpa/org-contacts.el")
;; (require 'org-contacts)

;; (load "~/.emacs.d/elpa/outline-presentation.el")
;; (require 'outline-presentation)

                                        ;(setq org-default-notes-file (concat org-directory "~/Dropbox/inbox.txt"))
;;(define-key global-map [f12] 'org-capture)
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
      `(("t" "Todo" entry (file+headline "~/Dropbox/Txt/todo.txt" "Inbox")
         "* TODO %? \n%U\n")
        ("n" "Note" entry (file+headline "~/Dropbox/Txt/inbox.txt" "Note")
         "* %? \n%U\n")
        ("l" "Link" entry (file+headline "~/Dropbox/Txt/inbox.txt" "Link")
         "* %? \n%U\n")
        ("c" "Contact" entry (file+headline "~/Dropbox/Txt/contacts.txt" "Contact")
         "* %?
:PROPERTIES:
:EMAIL: 
:URL:
:MOBILE:
:LOCATION:
:BIRTHDAY: 
:NOTE:
:END:")))

(global-set-key "\C-ca" 'org-agenda)
(setq org-export-coding-system 'utf-8)
(setq org-agenda-convert-date 'Chinese)
(setq diary-file "~/Dropbox/Txt/diary")
(setq org-agenda-include-diary t)
;;(setq org-agenda-files '("~/org"))

;;org-timeline
;; (defvar org-timeline-files nil
;;   "The files to be included in `org-timeline-all-files'. Follows
;;   the same rules as `org-agenda-files'")

;; (setq org-timeline-files '("/home/zhangtao/Dropbox/log/org/"))

;; (add-to-list 'org-agenda-custom-commands
;;              '("R" "Week in review"
;;                 agenda ""
;;                 ;; agenda settings
;;                 ((org-agenda-span 'week)
;;                   (org-agenda-start-on-weekday 0) ;; start on Sunday
;;                   (org-agenda-overriding-header "Week in Review")
;;                   (org-agenda-files 
;;                     (let ((org-agenda-files org-timeline-files))
;;                           (org-agenda-files nil 'ifmode)))
;;                   (org-agenda-start-with-log-mode t)
;;                   (org-agenda-log-mode-items '(clock state))
;;                   (org-agenda-archives-mode t) ; include archive files
;;                 )))


(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-crypt-tag-matcher "Secret")
(setq org-tags-exclude-from-inheritance (quote("Secret")))
(setq org-crypt-key nil)

;----------------------
;auctex+XeCJK
;----------------------

(add-to-list 'load-path "~/.emacs.d/elpa/auctex-11.89/")
(load "auctex.el" nil t t)
(load "preview.el" nil t t)
(require 'tex-mik)
(require 'tex)

(TeX-global-PDF-mode t)
(setq preview-image-type 'svg)
;; only start server for okular comms when in latex mode
(add-hook 'LaTeX-mode-hook 'server-start)
(setq TeX-PDF-mode t) ;; use pdflatex instead of latex
(setq TeX-newline-function 'newline-and-indent)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Standard emacs/latex config
;; http://emacswiki.org/emacs/AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; enable auto-fill mode, nice for text
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable synctex correlation
(setq TeX-source-correlate-method 'synctex)
;; Enable synctex generation. Even though the command shows
;; as "latex" pdflatex is actually called
;;(custom-set-variables '(LaTeX-command "latex -synctex=1") )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use Okular as the pdf viewer. Build okular 
;; command, so that Okular jumps to the current line 
;; in the viewer.
(setq TeX-view-program-selection
      '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "okular --unique %o#src:%n%b")))

(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                              "xelatex -interaction nonstopmode %f"))

;;(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

;;(setq org-latex-create-formula-image-program 'dvipng)

(setq org-latex-create-formula-image-program 'imagemagick)
(add-hook 'LaTeX-mode-hook (lambda ()
                             (push 
                              '("Latex_outdir" "%`latex -auxt-directory=/tmp %(mode)%' %t" 
                                TeX-run-TeX nil (latex-mode doctex-mode) 
                                :help "Run pdflatex with output in /tmp")
                              TeX-command-list)))

;;(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "pyg")))
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "pyg")))

(advice-add 'org-latex-compile :after #'delete-file)

;;-------------------------------------------------------
;;ox-latex
;;-------------------------------------------------------

(require 'ox-latex) ;;sudo pip install pygmentize https://emacs-china.org/t/spacemacs-org-mode-pdf/1577/15

(setq org-export-latex-listings t)

;;org-mode source code setup in exporting to latex
(add-to-list 'org-latex-listings
             '("" "listings"))
(add-to-list 'org-latex-listings
             '("" "color"))
(add-to-list 'org-latex-packages-alist
             '("" "xcolor" t))
(add-to-list 'org-latex-packages-alist
             '("" "listings" t))
(add-to-list 'org-latex-packages-alist
             '("" "fontspec" t))
(add-to-list 'org-latex-packages-alist
             '("" "indentfirst" t))
(add-to-list 'org-latex-packages-alist
             '("" "xunicode" t))
(add-to-list 'org-latex-packages-alist
             '("" "geometry"))
(add-to-list 'org-latex-packages-alist
             '("" "float"))
(add-to-list 'org-latex-packages-alist
             '("" "longtable"))
(add-to-list 'org-latex-packages-alist
             '("" "tikz"))
(add-to-list 'org-latex-packages-alist
             '("" "fancyhdr"))
(add-to-list 'org-latex-packages-alist
             '("" "textcomp"))
(add-to-list 'org-latex-packages-alist
             '("" "amsmath"))
(add-to-list 'org-latex-packages-alist
             '("" "tabularx" t))
(add-to-list 'org-latex-packages-alist
             '("" "booktabs" t))
(add-to-list 'org-latex-packages-alist
             '("" "grffile" t))
(add-to-list 'org-latex-packages-alist
             '("" "wrapfig" t))
(add-to-list 'org-latex-packages-alist
             '("normalem" "ulem" t))
(add-to-list 'org-latex-packages-alist
             '("" "amssymb" t))
(add-to-list 'org-latex-packages-alist
             '("" "capt-of" t))
(add-to-list 'org-latex-packages-alist
             '("figuresright" "rotating" t))
(add-to-list 'org-latex-packages-alist
             '("Lenny" "fncychap" t))

(add-to-list 'org-latex-classes
             '("org-book"
               "\\documentclass{book}
\\usepackage[slantfont, boldfont]{xeCJK}
% chapter set
\\usepackage{titlesec}
\\usepackage{hyperref}

[NO-DEFAULT-PACKAGES]
[PACKAGES]

\\setmainfont{Times New Roman}
\\setsansfont{Helvetica}
\\setmonofont{Courier New}

\\setCJKmainfont{SimSun} 
\\setCJKsansfont{Microsoft YaHei} 
\\setCJKmonofont{FZYTK.ttf} 

%如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。
\\defaultfontfeatures{Mapping=tex-text}

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left,
numberstyle= \\tiny,
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},
frame=shadowbox,
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20}
}

[EXTRA]
"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '("org-article"
                 "\\documentclass{article}
\\usepackage[slantfont, boldfont]{xeCJK}
\\usepackage{titlesec}
\\usepackage{hyperref}

[NO-DEFAULT-PACKAGES]
[PACKAGES]

\\parindent 2em

\\setmainfont{Times New Roman}
\\setsansfont{Helvetica}
\\setmonofont{Courier New}

\\setCJKmainfont{SimSun} 
\\setCJKsansfont{Microsoft YaHei} 
\\setCJKmonofont{FZYTK.ttf} 

%如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。
\\defaultfontfeatures{Mapping=tex-text}

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left,
numberstyle= \\tiny,
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},
frame=shadowbox,
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20}
}

[EXTRA]
"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '("org-beamer"
                 "\\documentclass{beamer}
\\usepackage[SlantFont, BoldFont]{xeCJK}
% beamer set
\\usepackage[none]{hyphenat}
\\usepackage[abs]{overpic}

[NO-DEFAULT-PACKAGES]
[PACKAGES]

\\setmainfont{Times New Roman}
\\setsansfont{Helvetica}
\\setmonofont{Courier New}

\\setCJKmainfont{SimSun} 
\\setCJKsansfont{Microsoft YaHei} 
\\setCJKmonofont{FZYTK.ttf} 

%如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。
\\defaultfontfeatures{Mapping=tex-text}

% 中文断行
\\XeTeXlinebreaklocale \"zh\"
\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

% 代码设置
\\lstset{numbers=left,
numberstyle= \\tiny,
keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},
frame=shadowbox,
breaklines=true,
rulesepcolor= \\color{ red!20!green!20!blue!20}
}

[EXTRA]
"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (add-hook 'org-mode-hook
;;       (lambda () 
;;         (add-to-list 'org-latex-classes
;;              '("ctexart"
;;                "\\documentclass{ctexart}"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\subsection{%s}" . "\\subsection*{%s}")
;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))


;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted)
;;   (setq org-latex-pdf-process
;;         '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; ;; (setq org-latex-minted-options
;; ;;         '(("frame" "lines") ("linenos=true")))
;; (setq org-latex-custom-lang-environments
;;            '(
;;             (emacs-lisp "common-lispcode")
;;              ))
;; (setq org-latex-minted-options
;;            '(("frame" "")
;;              ("fontsize" "\\scriptsize")
;;              ("linenos=false" "")))

;; (setq org-latex-to-pdf-process 
;;       '("xelatex -interaction nonstopmode %f"
;; 	"xelatex -interaction nonstopmode %f"))


;; (setq org-latex-to-pdf-process 
;;       '("xelatex --shell-escape -interaction nonstopmode %f"
;; 	"xelatex --shell-escape -interaction nonstopmode %f"))


;;(setq org-src-fontify-natively t)


;;-------------------------------------------------------

;; (require 'epa-file) 
;; (epa-file-enable) 
;; (setq epa-file-select-keys 0)
;; ;;(setq epa-file-encrypt-to nil) 
;; ;;-*- epa-file-encrypt-to: ("your@email.address") -*-
;; (setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; (setq epa-file-inhibit-auto-save nil) 

;;image
;; (image-type-available-p 'png)
;; (image-type-available-p 'jpeg)
;; (image-type-available-p 'gif)
;; (image-type-available-p 'tiff)
;; (image-type-available-p 'xbm)
;; (image-type-available-p 'xpm)

;;flyspell
;; (let ((langs '("american" "francais" "brasileiro")))
;;   (    setq lang-ring (make-ring (length langs)))
;;   (dolist (elem langs) (ring-insert lang-ring elem)))
;; (defun cycle-ispell-languages ()
;;   (interactive)
;;   (let ((lang (ring-ref lang-ring -1)))
;;     (ring-insert lang-ring lang)
;;     (ispell-change-dictionary lang)))
;; (global-set-key [f6] 'cycle-ispell-languages)


;; Setting up matlab-mode
;; (add-to-list 'load-path "~/.emacs.d/elpa/matlab-emacs")
;; (load-library "matlab-load")
(add-hook 'matlab-mode-hook 'auto-complete-mode)
(setq auto-mode-alist
      (cons
       '("\\.m$" . matlab-mode)
       auto-mode-alist))

                                        ;------------------------------------------------------------
;backup
;------------------------------------------------------------

(setq backup-directory-alist '(("" . "~/.backup")))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backp files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 7              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;;-----------------------------------------------------------
;;auto-save
;;-----------------------------------------------------------
(super-save-mode +1)
;; (setq auto-save-default nil)
(setq super-save-auto-save-when-idle t)

;; (defun full-auto-save ()
;; 	  (interactive)
;; 	  (save-excursion
;; 		(dolist (buf (buffer-list))
;; 		  (set-buffer buf)
;; 		  (if (and (buffer-file-name) (buffer-modified-p))
;; 			  (basic-save-buffer)))))
;; 	(add-hook 'auto-save-hook 'full-auto-save)
;;-----------------------------------------------------------


;; '(markdown-command
;;   "/usr/bin/pandoc -c ~/Dropbox/Linux/css/markdown/Clearness.css")
;; '(matlab-shell-command-switches (quote ("-nodesktop -nosplash")))
;; '(org-agenda-files
;;   (quote
;;    ("~/Dropbox/Txt/todo.txt" "~/Dropbox/Txt/inbox.txt")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
'(truncate-partial-width-windows nil)
 '(org-agenda-files (quote ("~/Dropbox/Txt/todo.txt")))
 '(package-selected-packages
   (quote
    (evil-matchit jedi zenburn-theme writeroom-mode window-numbering websocket web-mode super-save solarized-theme smooth-scrolling smex smart-mode-line-powerline-theme semi rtags request relative-line-numbers python-mode py-autopep8 pos-tip ox-latex-chinese neotree multi-term minimap matlab-mode markdown-mode magit log4e linum-relative key-chord jdee htmlize ht helm-ag gntp focus flatui-theme expand-region evil-surround evil-leader emmet-mode elpy dracula-theme cmake-ide clang-format cl-generic cal-china-x autopair auto-complete-clang auto-complete-c-headers ag ace-window ace-pinyin ace-isearch))))
