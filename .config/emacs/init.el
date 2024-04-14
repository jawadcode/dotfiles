;;; init.el --- Personal configuration -*- lexical-binding: t -*-

(if (eq system-type 'windows-nt)
  (progn
    (set-face-attribute 'default nil
                        :font "Iosevka Term SS07"
                        :height 150
                        :weight 'regular)
    (set-face-attribute 'variable-pitch nil
                        :font "Segoe UI"
                        :height 150
                        :weight 'regular)
    (set-face-attribute 'fixed-pitch nil
                        :font "Iosevka Term SS07"
                        :height 150
                        :weight 'regular)))

(setq default-directory (getenv "HOME"))

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))
;; Windows moment
(elpaca-no-symlink-mode)

(elpaca elpaca-use-package
  (elpaca-use-package-mode)
  (setq use-package-always-ensure t))

;; Block until current queue processed.
(elpaca-wait)

(use-package diminish)

(use-package general :config (general-evil-setup))

(elpaca-wait)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(diminish 'visual-line-mode)

(use-package gcmh
  :custom
  ;; From doom emacs' early-init.el
  (gcmh-idle-delay 'auto) ; default is 15s
  (gcmh-auto-idle-delay-factor 10)
  (gcmh-high-cons-threshold (* 16 1024 1024)) ; 16mb
  :config (gcmh-mode 1)
  :diminish gcmh-mode)

(general-create-definer jawadcode/leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC" ; The only valid leader key
  :global-prefix "M-SPC")

;; Miscellaneous keybinds
(jawadcode/leader-keys
  "SPC" '(find-file :wk "Find file")
  "f"   '(:ignore t :wk "File")
  "f r" '(counsel-recentf :wk "Find recent files")
  "f c" '((lambda () (interactive) (find-file "~/.config/emacs/init.org")) :wk "Open emacs config")
  ";"   '(comment-line :wk "Comment lines"))

;; Help keybinds
(jawadcode/leader-keys
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable")
  "h r" '((lambda () (interactive) (load-file user-init-file) (load-file user-init-file)) :wk "Reload config"))

;; Toggle keybinds
(jawadcode/leader-keys
  "t"   '(:ignore t :wk "Toggle")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t v" '(visual-line-mode :wk "Toggle visual-line-mode"))

(use-package sudo-edit
  :config
  (jawadcode/leader-keys
    "s" '(:ignore t :wk "Sudo Edit")
    "s f" '(sudo-edit-find-file :wk "Sudo find file")
    "s e" '(sudo-edit :wk "Sudo edit file")))

(use-package evil
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-vsplit-window-right t)
  (evil-split-window-below t)
  :init
  :config
  (evil-mode 1)
  (jawadcode/leader-keys
    "w"   '(:ignore t :wk "Windows")

    ;; Window splits
    "w x" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New horizontal window")
    "w m" '(evil-window-vnew :wk "New vertical window")
    "w h" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")

    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")))

;; Extra evil stuff
(use-package evil-collection
  :after evil
  :custom (evil-collection-mode-list '(dashboard dired ibuffer))
  :config (evil-collection-init)
  :diminish evil-collection-unimpaired-mode)

(use-package evil-anzu :after evil)

(use-package evil-tutor)

;; Turns off elpaca-use-package-mode current declaration
;; Note this will cause the declaration to be interpreted immediately (not deferred).
;; Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))

;; Don't install anything. Defer execution of BODY
(elpaca nil (message "deferred"))

(use-package which-key
  :init (which-key-mode 1)
  :custom
  (which-key-add-column-padding 3)
  (which-key-idle-delay 0.1)
  :diminish which-key-mode)

(use-package treemacs
  :config
  (jawadcode/leader-keys
    "t t" '((lambda () (treemacs)) :wk "Toggle treemacs")))

(use-package treemacs-evil :after (treemacs evil))

(use-package treemacs-projectile :after (treemacs projectile))

(use-package treemacs-all-the-icons :after (treemacs all-the-icons))

(use-package treemacs-tab-bar :after treemacs)

(load (concat user-emacs-directory "buffer-move/buffer-move.el"))

(jawadcode/leader-keys
  ;; General Buffer Keybinds
  "b"   '(:ignore t :wk "Buffer")
  "b s" '(switch-to-buffer :wk "Switch buffer")
  "b i" '(ibuffer :wk "Interactive buffer")
  "b x" '(kill-this-buffer :wk "Kill this buffer")
  "b ]" '(next-buffer :wk "Next buffer")
  "b [" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer")

  ;; Buffer-Move Keybinds
  "b h" '(buf-move-left :wk "Buffer move left")
  "b j" '(buf-move-down :wk "Buffer move down")
  "b k" '(buf-move-up :wk "Buffer move up")
  "b l" '(buf-move-right :wk "Buffer move right"))

(use-package projectile
  :config
  (projectile-mode 1)
  (jawadcode/leader-keys
    "p" '(projectile-command-map :wk "Projectile"))
  :diminish projectile-mode)

(use-package all-the-icons
  :if (display-graphic-p))

;; This enables all-the-icons in the dired file manager
(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package ligature
  :config
  ;; Enable all Iosevka ligatures in programming modes
  (ligature-set-ligatures
   'prog-mode
   '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
    ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
    "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
    "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
    "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
    "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
    "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
    "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
    ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
    "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
    "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
    "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
    "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package dashboard
  :after (all-the-icons projectile)
  :init
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-icon-type 'all-the-icons)
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-startupify-list '(dashboard-insert-banner
                                    dashboard-insert-newline
                                    dashboard-insert-banner-title
                                    dashboard-insert-newline
                                    dashboard-insert-navigator
                                    dashboard-insert-newline
                                    dashboard-insert-init-info
                                    dashboard-insert-items))
  (setq dashboard-items '((recents   . 6)
                          (projects  . 6)
                          (bookmarks . 6)
                          (registers . 6)))
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(use-package solaire-mode :config (solaire-global-mode +1))

(window-divider-mode)

(use-package doom-themes
  :demand t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-material-dark t)

  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(setq org-indent-mode nil)

;; Org-mode keybinds
(jawadcode/leader-keys
  "m"   '(:ignore t :wk "Org")
  "m a" '(org-agenda :wk "Org agenda")
  "m e" '(org-export-dispatch :wk "Org export dispatch")
  "m i" '(org-toggle-item :wk "Org toggle item")
  "m t" '(org-todo :wk "Org todo")
  "m B" '(org-babel-tangle :wk "Org babel tangle")
  "m T" '(org-todo-list :wk "Org todo list"))

;; Org mode table keybinds
(jawadcode/leader-keys
  "m b"   '(:ignore t :wk "Tables")
  "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

;; Org mode datetime keybinds
(jawadcode/leader-keys
  "m d"   '(:ignore t :wk "Date/deadline")
  "m d t" '(org-time-stamp :wk "Org time stamp"))

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'org-tempo)

(use-package ivy
  ;; :bind
  ;; (("C-c C-r" . ivy-resume)
  ;;  ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode)
  (jawadcode/leader-keys
    "i"   '(:ignore t :wk "Ivy")
    "i r" '(ivy-resume :wk "Resume previous Ivy completion")
    "i b" '(ivy-switch-buffer-other-window :wk "Switch to another buffer in another window"))
  :diminish ivy-mode)

(use-package counsel
  :after ivy
  :config (counsel-mode)
  :diminish counsel-mode)

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode 1))

;; Adds bling to our ivy completions
(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1)
  :custom
  ;; I'll be honest, idk what this does
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transform))

(use-package company
  :config
  (define-key company-active-map (kbd "C-n") nil)
  (define-key company-active-map (kbd "C-p") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "M-j") #'company-select-next)
  (define-key company-active-map (kbd "M-k") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (global-company-mode)
  (diminish 'company-capf-mode)
  :diminish company-mode)

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode)
  :diminish company-box-mode)

(use-package smartparens-mode
  :ensure smartparens
  :hook (prog-mode text-mode markdown-mode)
  :config (require 'smartparens-config)
  :diminish smartparens-mode)

(use-package poly-org)

(use-package tree-sitter
  :after tree-sitter-langs
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)

(use-package lsp-mode
  :hook (((rust-mode             . lsp)
          (c-mode                . lsp)
          (c++-mode              . lsp)
          (meson-mode            . lsp))
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (evil-define-key 'normal lsp-mode-map (kbd "SPC l") lsp-command-map)
  :commands lsp
  :diminish flymake-mode)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package rust-mode :commands rust-mode)

(use-package lsp-pyright
  :config
  (add-hook 'pyright-mode-hook #'lsp))

(use-package haskell-mode :commands haskell-mode)
(use-package lsp-haskell
  :config
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp))

(use-package lean4-mode
  :ensure (lean4-mode
           :host github
           :repo "leanprover/lean4-mode"
           :files ("*.el" "data"))
  :commands lean4-mode)

(use-package idris2-mode
  :ensure (idris2-mode
           :host github
           :repo "idris-community/idris2-mode")
  :commands idris2-mode)

(use-package meson-mode :commands meson-mode)

(use-package cmake-mode :commands cmake-mode)
