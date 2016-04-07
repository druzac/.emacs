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

;; haskell junk
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; fix org mode C-j vs RET nonsense
(add-hook 'org-mode-hook (lambda ()
                           (progn (local-set-key (kbd "C-j") #'org-return)
                                  (local-set-key (kbd "RET") #'org-return-indent))))

;; magit junk
(setq magit-last-seen-setup-instructions "1.4.0")

;; hide menu
(menu-bar-mode -1)

;; c settings
(setq-default c-basic-offset 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (elixir-mode jtags zenburn-theme rust-mode puppet-mode paredit markdown-mode magit json-mode haskell-mode groovy-mode dockerfile-mode cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
