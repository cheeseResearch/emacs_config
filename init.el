;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    helm
    ein
    elpy
    conda
    flycheck
    magit
    material-theme
    py-autopep8
    org-roam))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(menu-bar-mode -1) ;; hide the menu bar

(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; auto save often
;; save every 20 characters typed (this is the minimum)
(setq auto-save-interval 20)

;; setup helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x) ;; set helm to given keybinding
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

;; Closing brackets is a pain
(electric-pair-mode 1)

;; Spall checking is important
(setenv "DICTIONARY" "en_GB")
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))

;; Org Configuration
;; --------------------------------------
(setq org-roam-directory "somewhere")


;; keys
(global-set-key (kbd "C-c n r") #'org-roam-buffer-toggle-display)
(global-set-key (kbd "C-c n i") #'org-roam-insert)
(global-set-key (kbd "C-c n /") #'org-roam-find-file)
(global-set-key (kbd "C-c n b") #'org-roam-switch-to-buffer)
(global-set-key (kbd "C-c n d") #'org-roam-find-directory)



;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

(conda-env-autoactivate-mode t)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (conda py-autopep8 material-theme org-roam flycheck elpy ein magit better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
