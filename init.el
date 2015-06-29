(setq package-enable-at-startup nil)
; setting up package repositories
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t))

(require 'cl)

;; list of packages to install
(let ((packages (list 'zenburn-theme 'groovy-mode 'rust-mode 'magit))
      (cond-add-package (lambda (ps p)
			  (if (not (package-installed-p p))
			      (cons p ps)
			    ps))))
  (let ((to-install (cl-reduce cond-add-package packages :initial-value '())))
    (if to-install
	(progn
	  (package-refresh-contents)
	  (mapc 'package-install to-install)))))

(load-theme 'zenburn t)

;; gradle junk
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code" t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;; make the evil evil tabs go away
(setq-default indent-tabs-mode nil)

;; column number in the mode line
(setq column-number-mode t)

;; uniquify buffers
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'reverse
 uniquify-separator ":")

;; ugh - package to fix path for OS X
(when (memq window-system '(mac ns))
  (when (not (package-installed-p 'exec-path-from-shell))
    (package-refresh-contents)
    (package-install 'exec-path-from-shell))
  (exec-path-from-shell-initialize))

;; paredit
(add-hook 'clojure-mode-hook
  (lambda () (paredit-mode)))
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(setq magit-last-seen-setup-instructions "1.4.0")
