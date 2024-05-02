;;; early-init.el --- Early initialisation -*- lexical-binding: t -*-

(setq gc-cons-threshold most-positive-fixnum
      read-process-output-max (* 1024 1024)
      package-enable-at-startup nil
      native-comp-async-report-warnings-errors 'silent
      byte-compile-warnings nil
      inhibit-startup-screen t
      warning-minimum-level :error)

(setenv "LSP_USE_PLISTS" "true")

(setq ;; menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil
      column-number-mode t)

; (add-to-list 'default-frame-alist '(foreground-color . "#EEFFFF"))
; (add-to-list 'default-frame-alist '(background-color . "#212121"))
; Causes flashes 🤔

(pcase system-type
  ('windows-nt ()) ; Can't set font in early-init.el on Windows apparently
  ('gnu/linux
   (progn
    (set-face-attribute 'default nil
      :font "IosevkaTermSS07 Nerd Font"
      :height 150
      :weight 'regular)
    (set-face-attribute 'variable-pitch nil
      :font "Roboto"
      :height 150
      :weight 'regular)
    (set-face-attribute 'fixed-pitch nil
      :font "IosevkaTermSS07 Nerd Font"
      :height 150
      :weight 'regular))))
