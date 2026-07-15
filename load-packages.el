(setq packages-to-install '(
          ace-window
          avy
          corfu
          corfu-terminal
          consult
          dash
          emacs-everywhere
          envrc
          evil
          f
          format-all
          fzf
          gdscript-mode
          git-gutter
          gruvbox-theme
          inheritenv
          ivy
          ivy-prescient
          lsp-java
          lsp-mode
          lsp-ui
          magit
          magit-section
          marginalia
          nix-mode
          orderless
          org
          org-fragtog
          org-roam
          org-roam-timestamps
          org-roam-ui
          ox-gfm
          pdf-tools
          projectile
          rustic
          simple-httpd
          smartparens
          sqlite3
          surround
          treemacs
          treemacs-evil
          vertico
          multi-vterm
          vterm
          websocket
          yaml-mode
          ein
	  ))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(dolist (p packages-to-install)
  (package-install p))

(provide 'load-packages)
