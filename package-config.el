;; -*- lexical-binding: t; -*-


(use-package evil
  :config
  (evil-set-undo-system 'undo-redo)
  )

(use-package org
  ;;:after corfu
  :init
  :hook (org-mode . org-mode-enable)
  :config
  (setq org-format-latex-options (plist-put org-format-latex-options ':scale 1.5))
  (setq org-roam-directory (file-truename "~/org")
        org-id-locations-file (expand-file-name ".org-id-locations" org-roam-directory)
        org-roam-db-location (expand-file-name "org-roam-db" org-roam-directory))
  (setq org-preview-latex-default-process 'dvipng)
  (defun org-id-reload-all ()
    (interactive)
    (org-id-update-id-locations)
    (org-roam-update-org-id-locations)
    (org-roam-db-sync))
  (defun org-mode-enable ()
    (org-fragtog-mode 1)
    (org-indent-mode 1)
    (org-roam-db-autosync-mode 1)
    ;(corfu-mode -1)
    )
  )

;(use-package corfu
;  :hook (prog-mode . corfu-mode))

(use-package rustic
  :after (inheritenv f))

(use-package lsp-mode
  :hook ((java-mode c++-mode rustic-mode) . lsp-mode)
  :config
  (define-key lsp-mode-map (kbd "C-c C-j C-j") #'lsp-execute-code-action)
  )

(use-package multi-vterm
  :after (projectile))

(use-package key-chord
  :after (org)
  :init
  (key-chord-mode 1)
  :config
                                        ;(key-chord-define org-mode-map "hl" 'org-insert-latex-brace)
  )

(use-package yasnippet
  :after (org evil)
  :init
                                        ;:hook ((org-mode) . yas-minor-mode)
  :config
  (yas-reload-all)
  (yas-global-mode 1)
  )

(provide 'package-config)
