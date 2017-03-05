(require 'package)
;; MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;; MELPA-stable
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; Maramalable
;(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; Org
;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))
;; 初期化
(package-initialize)

;; global
(global-set-key (kbd "C-h") `delete-backward-char)
(global-set-key (kbd "M-g") `goto-line)
(global-set-key (kbd "C-c t") `toggle-truncate-lines)

;; basic
(show-paren-mode t)
(setq-default column-number-mode t)
(setq-default truncate-partial-width-windows t)

;; indent
(setq-default tab-width 4)
(setq tab-stop-list
  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(setq-default indent-tabs-mode nil)

;; c
(setq-default c-basic-offset 4)
(setq-default c-default-style "bsd")

;; php-mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(setq-default php-mode-force-pear t)

;; js2-mode
(setq-default js-indent-level 2)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
