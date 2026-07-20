(load-file "~/.emacs.d/load-packages.el")
(load-file "~/.emacs.d/package-config.el")
(load-file "~/.emacs.d/functions.el")
(load-file "~/.emacs.d/keybinds.el")

;; First, we set basic configs - relative line numbers, silenced sound effects,
;; autocomplete, etc.
(setq display-line-numbers 'relative
      ring-bell-function 'ignore
      inhibit-startup-screen t

      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-styles '(basic substring partial-completion flex)
      warning-suppress-log-types '((files missing-lexbind-cookie)))

;; Set custom file
(setq custom-file "~/.emacs.d/custom.el")

;; General stuff to make things look nicer
(load-theme 'gruvbox t)
(set-face-attribute 'default nil :font "Maple Mono" :height 160)
(toggle-truncate-lines 1)

;; We set our basic global modes
(evil-mode 1)
(vertico-mode 1)
(ivy-mode 1)
(global-corfu-mode 1)
(ivy-prescient-mode 1)
(org-roam-db-autosync-mode 1)
(which-key-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(indent-tabs-mode 0)
(recentf-mode 1)


(defun prog-mode-enable ()
    (display-line-numbers-mode 1)
    (setq display-line-numbers 'relative)
    (indent-tabs-mode 0)
    (format-all-mode 1)
)

(add-hook 'prog-mode-hook 'prog-mode-enable)

(add-hook 'text-mode-hook 'visual-line-mode)

(when (memq window-system '(mac ns x pgtk))
  (exec-path-from-shell-initialize))
(when (daemonp)
  (exec-path-from-shell-initialize))

(load-file "~/.emacs.d/custom.el")

(require 'package-config)
(require 'functions)
(require 'keybinds)
(require 'custom)
