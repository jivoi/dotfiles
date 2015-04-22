(defun system-is-linux ()
    "Linux system checking."
    (interactive)
    (string-equal system-type "gnu/linux"))

(defun system-is-mac ()
    "Mac OS X system checking."
    (interactive)
    (string-equal system-type "darwin"))

(defun system-is-windows ()
    "MS Windows system checking."
    (interactive)
    (string-equal system-type "windows-nt"))

;; Start Emacs server. Require Midnight
(unless (system-is-windows)
    (require 'server)
    (unless (server-running-p)
        (server-start)))
(require 'midnight)

;; User name and e-mail
(setq user-full-name   "ekoz")
(setq user-mail-adress "don.eugen@gmail.com")

;; Paths (for Common Lisp compiler - SBCL)
(setq unix-sbcl-bin    "/usr/bin/sbcl")
(setq windows-sbcl-bin "C:/sbcl/sbcl.exe")

;; Package manager:
;; Initialise package and add Melpa repository
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Package list
(defvar required-packages
  '(slime
    powerline
    projectile
    auto-complete
    soft-charcoal-theme))

;; Require Common Lisp extensions
(require 'cl)

(defun packages-installed-p ()
    "Packages availability checking."
    (interactive)
    (loop for package in required-packages
          unless (package-installed-p package)
            do (return nil)
          finally (return t)))

;; Auto-install packages
(unless (packages-installed-p)
    (message "%s" "Emacs is now refreshing it's package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    (dolist (package required-packages)
        (unless (package-installed-p package)
            (package-install package))))

;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top)

;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t)
(setq imenu-use-popup-menu nil)

;; Display the name of the current buffer in the title
(setq frame-title-format "GNU Emacs: %b")

;; Org-mode
(require 'org)

;; Inhibit start-up/splash screen
(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t)

;; Show-paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; Electric-mode
(electric-pair-mode    1)
(electric-indent-mode -1)

;; Delete selection
(delete-selection-mode t)

;; Disable GUI components
(tooltip-mode      -1)
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq use-dialog-box     nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore)

;; Fringe
(fringe-mode '(8 . 0))
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; Window size. Set font
(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(height . 50))
(when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono-11" nil t))

;; Disable backup/auto-save files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

;; Coding-system
(set-language-environment 'UTF-8)
(if (or (system-is-linux) (system-is-mac))
    (progn
        (setq default-buffer-file-coding-system 'utf-8)
        (setq-default coding-system-for-read    'utf-8)
        (setq file-name-coding-system           'utf-8)
        (set-selection-coding-system            'utf-8)
        (set-keyboard-coding-system        'utf-8-unix)
        (set-terminal-coding-system             'utf-8)
        (prefer-coding-system                   'utf-8))
    (progn
        (prefer-coding-system                   'windows-1251)
        (set-terminal-coding-system             'windows-1251)
        (set-keyboard-coding-system        'windows-1251-unix)
        (set-selection-coding-system            'windows-1251)
        (setq file-name-coding-system           'windows-1251)
        (setq-default coding-system-for-read    'windows-1251)
        (setq default-buffer-file-coding-system 'windows-1251)))

;; Linum plug-in
(require 'linum)
(line-number-mode   t)
(global-linum-mode  t)
(column-number-mode t)
(setq linum-format " %d")

;; Display file size/time in mode-line
(setq display-time-24hr-format t)
(display-time-mode             t)
(size-indication-mode          t)

;; Line wrapping. Fill column
(setq word-wrap          t)
(global-visual-line-mode t)
(setq-default fill-column 80)

;; IDO plug-in
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)

;; Buffer selection and Ibuffer
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)

;; Syntax highlighting
(require 'font-lock)
(global-hl-line-mode               t)
(global-font-lock-mode             t)
(setq font-lock-maximum-decoration t)

;; Indentation
(defalias 'perl-mode 'cperl-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width            4)
(setq-default python-indent        4)
(setq-default c-basic-offset       4)
(setq-default standart-indent      4)
(setq-default lisp-body-indent     4)
(setq-default cperl-indent-level   4)
(setq-default python-indent-offset 4)
(setq lisp-indent-function 'common-lisp-indent-function)

;; Scrolling
(setq scroll-step               1)
(setq scroll-margin            10)
(setq scroll-conservatively 10000)

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Global clipboard
(setq x-select-enable-clipboard t)

;; File end newlines
(setq require-final-newline    t)
(setq next-line-add-newlines nil)

;; Highlight search results
(setq search-highlight        t)
(setq query-replace-highlight t)

;; Easy transition between buffers: M-{arrow keys}
(unless (equal major-mode 'org-mode)
    (windmove-default-keybindings 'meta))

(defun format-buffer ()
    "Format buffer."
    (interactive)
    (save-excursion (delete-trailing-whitespace)
                    (unless (equal major-mode 'python-mode)
                        (indent-region (point-min) (point-max)))
                    (unless indent-tabs-mode
                        (untabify (point-min) (point-max))))
    nil)
(add-to-list 'write-file-functions 'format-buffer)

;; CEDET
(require 'cedet)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
(semantic-mode   t)
(global-ede-mode t)
(require 'ede/generic)
(require 'semantic/ia)
(ede-enable-generic-projects)

;; Bookmarks
(require 'bookmark)
(setq bookmark-save-flag t)
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t))
(setq bookmark-default-file (concat user-emacs-directory "bookmarks"))

;; Skeletons:
;; Python skeleton
(define-skeleton python-skeleton
    "Python initialise skeleton" nil
    "#!/usr/bin/env python\n"
    "# -*- coding: utf-8 -*-\n"
    "\n"_)

;; Perl skeleton
(define-skeleton perl-skeleton
    "Perl initialise skeleton" nil
    "#!/usr/bin/env perl\n\n"
    "use warnings;\n"
    "use strict;\n"
    "\n"_)

;; Auto-insert mode
(require 'autoinsert)
(auto-insert-mode)
(setq auto-insert-query nil)
(define-auto-insert "\\.py\\'" 'python-skeleton)
(define-auto-insert "\\.\\(pl\\|pm\\)\\'" 'perl-skeleton)

;; Plug-ins:
(when (packages-installed-p)

    ;; Soft-charcoal-theme 
    (load-theme 'soft-charcoal t)

    ;; Powerline
    (require 'powerline)
    (powerline-default-theme)

    ;; Auto-complete
    (require 'auto-complete)
    (require 'auto-complete-config)
    (ac-config-default)
    (setq ac-auto-start        t)
    (setq ac-auto-show-manu    t)
    (global-auto-complete-mode t)
    (add-to-list 'ac-modes 'lisp-mode)

    ;; SLIME
    (require 'slime)
    (require 'slime-autoloads)
    (setq slime-net-coding-system 'utf-8-unix)
    (slime-setup '(slime-fancy slime-asdf slime-indentation))
    (if (or (file-exists-p unix-sbcl-bin) (file-exists-p windows-sbcl-bin))
        (if (system-is-windows)
            (setq inferior-lisp-program windows-sbcl-bin)
            (setq inferior-lisp-program unix-sbcl-bin))
        (message "%s" "SBCL not found..."))
    (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))

    ;; Projectile
    (require 'projectile)
    (projectile-global-mode))

;; Key-bindings: Motion keys:
;; Go to previous line
(global-set-key (kbd "M-i") 'previous-line)
;; Go to next line
(global-set-key (kbd "M-k") 'next-line)
;; Backward char
(global-set-key (kbd "M-j") 'backward-char)
;; Froward char
(global-set-key (kbd "M-l") 'forward-char)
;; Backward word
(global-set-key (kbd "M-u") 'backward-word)
;; Forward ward
(global-set-key (kbd "M-o") 'forward-word)
;; Go to line beginning
(global-set-key (kbd "M-a") 'beginning-of-visual-line)
;; Go to line end
(global-set-key (kbd "M-e") 'end-of-visual-line)
;; Go to function beginning
(global-set-key (kbd "C-a") 'beginning-of-defun)
;; Go to function end
(global-set-key (kbd "C-e") 'end-of-defun)
;; Scroll up
(global-set-key (kbd "M-n") 'scroll-up-command)
;; Scroll down
(global-set-key (kbd "M-h") 'scroll-down-command)
;; Beginning of buffer
(global-set-key (kbd "M-,") 'beginning-of-buffer)
;; End of buffer
(global-set-key (kbd "M-.") 'end-of-buffer)
;; Backward list
(global-set-key (kbd "M-[") 'backward-list)
;; Forward list
(global-set-key (kbd "M-]") 'forward-list)

;; Killing and Deleting:
;; Kill region
(global-set-key (kbd "M-x") 'kill-region)
;; Kill ring and save
(global-set-key (kbd "M-c") 'kill-ring-save)
;; Yank
(global-set-key (kbd "M-v") 'yank)
;; Delete backward char
(global-set-key (kbd "M-;") 'delete-backward-char)
;; Delete forward char
(global-set-key (kbd "M-'") 'delete-forward-char)
;; Kill whole line
(global-set-key (kbd "M-d") 'kill-whole-line)
;; Kill visual line
(global-set-key (kbd "M-f") 'kill-visual-line)
;; Kill word
(global-set-key (kbd "M-w") 'kill-word)
;; Transpose words
(global-set-key (kbd "M-t") 'transpose-words)

;; Files and Buffers:
;; Find or create file
(global-set-key (kbd "C-f") 'ido-find-file)
;; Switch buffer
(global-set-key (kbd "M-b") 'ido-switch-buffer)
;; Ido kill buffer
(global-set-key (kbd "C-d") 'ido-kill-buffer)
;; Save file
(global-set-key (kbd "M-g") 'save-buffer)
;; Ido write file
(global-set-key (kbd "C-w") 'ido-write-file)
;; Save buffers and kill terminal
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)
;; Delete other window
(global-set-key (kbd "C-1") 'delete-other-windows)
;; Split window bellow
(global-set-key (kbd "C-2") 'split-window-below)
;; Split window right
(global-set-key (kbd "C-3") 'split-window-right)
;; Delete window
(global-set-key (kbd "C-0") 'delete-window)
;; Window move up
(global-set-key (kbd "C-i") 'windmove-up)
;; Window move down
(global-set-key (kbd "C-k") 'windmove-down)
;; Window move left
(global-set-key (kbd "C-j") 'windmove-left)
;; Window move right
(global-set-key (kbd "C-l") 'windmove-right)

;; Commands:
;; Undo
(global-set-key (kbd "M-z") 'undo)
;; Keyboard quit
(global-set-key (kbd "M-q") 'keyboard-quit)
;; Newline and indent
(global-set-key (kbd "RET") 'newline-and-indent)

(defun function-newline-and-indent ()
    "Clever newline."
    (interactive)
    (end-of-visual-line)
    (newline-and-indent))
(global-set-key (kbd "M-RET") 'function-newline-and-indent)

(defun add-line-above ()
    "Add line above."
    (interactive)
    (previous-line)
    (function-newline-and-indent))
(global-set-key (kbd "C-o") 'add-line-above)

(defun python-newline ()
    "Clever Python newline."
    (interactive)
    (end-of-visual-line)
    (insert ":")
    (newline-and-indent))
(global-set-key (kbd "M-r") 'python-newline)

(defun java-newline ()
    "Clever Java newline."
    (interactive)
    (end-of-visual-line)
    (insert " {")
    (newline-and-indent)
    (insert "}")
    (previous-line)
    (format-buffer)
    (function-newline-and-indent))
(global-set-key (kbd "M-y") 'java-newline)

;; Add comment according major mode
(global-set-key (kbd "M-/") 'comment-dwim)
;; Set mark command
(global-set-key (kbd "M-m") 'set-mark-command)
;; Back to indentation
(global-set-key (kbd "M-\\") 'back-to-indentation)

;; Functional keys:
;; Buffer selection
(global-set-key (kbd "<f2>") 'bs-show)

;; Bookmark key-bindings
(global-set-key (kbd "<f3>") 'bookmark-set)
(global-set-key (kbd "<f4>") 'bookmark-jump)
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list)

;; Imenu key-bindings
(global-set-key (kbd "<f6>") 'imenu)

;; Keyboard macros
(global-set-key (kbd "<f7>") 'kmacro-start-macro)
(global-set-key (kbd "<f8>") 'kmacro-end-macro)
(global-set-key (kbd "<f9>") 'kmacro-call-macro)

;; Menu bar
(global-set-key (kbd "<f10>") 'menu-bar-open)

;; Ido dired
(global-set-key (kbd "<f11>") 'ido-dired)

;; Execute command
(global-set-key (kbd "<f12>") 'execute-extended-command)

;; Org key-bindings:
(global-set-key (kbd "\C-ca") 'org-agenda)
(global-set-key (kbd "\C-cb") 'org-iswitchb)
(global-set-key (kbd "\C-cc") 'org-capture)
(global-set-key (kbd "\C-cl") 'org-store-link)
