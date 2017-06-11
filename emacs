;;; package --- Summary

;;; Commentary:
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-surround tex racer rust-mode intero helm-company helm exec-path-from-shell company-jedi flycheck-pyflakes elpy gruvbox-theme evil-nerd-commenter evil))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; (setq evil-want-C-u-scroll t)

(dolist (package package-selected-packages)
 (require package))



;;; Packages:
(evilnc-default-hotkeys)
(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))
(evil-mode 1)
(global-evil-surround-mode 1)

(exec-path-from-shell-initialize)

(elpy-enable)
(global-flycheck-mode)
(ido-mode t)

;; LaTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq-default TeX-engine 'xetex)
;(setq TeX-PDF-mode t)

;; rust
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)


;; python
(defun my/python-mode-hook ()
  "Enables jedi-mode (python) for company."
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

;; haskell
(add-hook 'haskell-mode-hook 'intero-mode)
;; (add-to-list 'load-path "/Users/ethan/.stack/snapshots/x86_64-osx/lts-4.0/7.10.3/share/x86_64-osx-ghc-7.10.3/HaRe-0.8.2.1/elisp")
;; ;; (require hare)
;; (autoload 'hare-init "hare" nil t)
;; (add-hook 'haskell-mode-hook (lambda () (ghc-init) (hare-init)))

;; code completion
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

;; (exec-path-from-shell-check-startup-files)

;;; Appearance:
(tool-bar-mode -1)
(scroll-bar-mode -1)
(display-time-mode)

;;; .emacs ends here
(put 'downcase-region 'disabled nil)
