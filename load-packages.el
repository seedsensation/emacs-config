(setq packages-to-install '(
			    ;; Appearance
			    gruvbox-theme
			    git-gutter

          ;; Typing
          avy
          evil
          key-chord
          surround
          yasnippet

			    ;; Org Mode
			    org
			    org-fragtog
			    org-roam
			    org-roam-timestamps
			    org-roam-ui

			    ;; Window Management
			    ace-window

			    ;; Navigation
			    consult
			    fzf
			    ivy
			    ivy-prescient
			    marginalia
			    vertico

			    ;; Programming
			    format-all
			    lsp-java
			    lsp-mode
			    lsp-ui
			    magit
			    magit-section
			    projectile
			    smartparens
			    treemacs
			    treemacs-evil
			    multi-vterm
			    vterm

			    ;; Modes
			    gdscript-mode
			    nix-mode
			    rustic
			    yaml-mode

			    ;; Completion
			    corfu
			    corfu-terminal

			    ;; Misc
			    emacs-everywhere
			    exec-path-from-shell
			    dash
			    orderless
			    ox-gfm
			    pdf-tools

			    ;; Dependencies
			    f
			    inheritenv
			    ))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (setq refreshed t))
(dolist (p packages-to-install)
  (package-install p))


(provide 'load-packages)
