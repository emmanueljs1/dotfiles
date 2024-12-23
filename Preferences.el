;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messages* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(exec-path-from-shell-initialize)

(load-file (let ((coding-system-for-read 'utf-8))
	     (shell-command-to-string "agda-mode locate")))

;; auto-load agda-mode for .agda and .lagda.md
(setq auto-mode-alist
   (append
     '(("\\.agda\\'" . agda2-mode)
       ("\\.lagda.tex\\'" . agda2-mode)
       ("\\.lagda.md\\'" . agda2-mode))
     auto-mode-alist))

;; Enable Evil
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

;; Force Agda input method
(require 'agda-input)
(add-hook 'agda2-mode-hook (lambda () (add-hook 'evil-normal-state-entry-hook (lambda () (set-input-method "Agda")))))
(add-hook 'agda2-mode-hook (lambda () (add-hook 'evil-normal-state-exit-hook (lambda () (set-input-method "Agda")))))

;; Vim yanks go to clipboard
(setq x-select-enable-clipboard t)

;; Mouse drags dont overwrite registers
(setq mouse-drag-copy-region nil)

;; Force agda input method when opening coq files
(add-hook 'coq-mode-hook (lambda () (add-hook 'evil-normal-state-entry-hook (lambda () (set-input-method "Agda")))))
(add-hook 'coq-mode-hook (lambda () (add-hook 'evil-normal-state-exit-hook (lambda () (set-input-method "Agda")))))
