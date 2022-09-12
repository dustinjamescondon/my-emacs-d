(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(setq visible-bell 1)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package ivy
  :ensure t
  :demand t
  :config
  (ivy-mode 1)
 )

(require 'magit)

;;--------------------------------------------------
;; Colors
;;..................................................
(set-foreground-color "#E0DFDB")
(set-background-color "#102372")
(add-to-list 'default-frame-alist '(foreground-color . "#E0DFDB"))
(add-to-list 'default-frame-alist '(background-color . "#102372"))

;;--------------------------------------------------
;; Capture Templates
;;..................................................
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/loose-tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;;--------------------------------------------------
;; RUST
;;..................................................
(use-package company)

(use-package rustic
  :mode ("\\.rs\\'" . rustic-mode))

(use-package dap-mode
  :mode ("\\.rs\\?'" . dap-mode))

;;--------------------------------------------------
;; Flycheck
;; NOTE: This is used to give some in-buffer error information
;; when cursor-ing over a squiggle
;;..................................................
(use-package flycheck)

;;--------------------------------------------------
;; LSP
;;
;; See here for some instructions:
;; https://robert.kra.hn/posts/rust-emacs-setup/
;;..................................................
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-rust-analyzer-server-display-inlay-hints nil);; [Dustin] I hate this one, so disable it
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints nil)
  (lsp-rust-analyzer-display-parameter-hints t)
  (lsp-rust-analyzer-display-reborrow-hints t)
  (lsp-ui-doc-show-with-mouse t)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-signature-render-documentation nil)
  (lsp-diagnostics-enable t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))
;;--------------------------------------------------
;; Money stuff that I never use
;;..................................................
(use-package ledger-mode)

;;--------------------------------------------------
;; Counsel
;; Will show the key shortcut of an M-x command if it exists
;;..................................................
(use-package counsel
  :config
  (when (commandp 'counsel-M-x)
  (global-set-key [remap execute-extended-command] #'counsel-M-x)))

;;--------------------------------------------------
;; 
;;..................................................

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(counsel counsel-mode flycheck rustic rustic-mode company company-mode use-package rust-mode magit ledger-mode ivy dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
