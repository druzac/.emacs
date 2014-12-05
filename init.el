(setq package-enable-at-startup nil)
; setting up package repositories
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t))

(global-linum-mode t)
(load-theme 'zenburn t)

; gradle junk
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code" t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

; paredit
(add-hook 'clojure-mode-hook
  (lambda () (paredit-mode)))
(add-hook 'cider-repl-mode-hook 'paredit-mode)

; make the evil evil tabs go away
(setq-default indent-tabs-mode nil)
