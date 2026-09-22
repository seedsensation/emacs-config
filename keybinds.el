;; -*- lexical-binding: t; -*-
(require 'load-packages)

;; I FUCKING LOVE MACROS
(defmacro define-keys (dest-map &rest args)
  `(progn ,@(mapcar #'(lambda (a) (append (list 'define-key dest-map) a )) args) t))

(defmacro set-local-leader-map (source-map key &rest args)
  `(progn
     (evil-define-key 'normal ,source-map (kbd "<SPC>")
       (let ((map (make-sparse-keymap)))
	 (set-keymap-parent map leader-map)
	 (define-key map (kbd ,key) ,(append
				      (list 'define-keymap)
				      args))

	 map))))
;; Non-package specific keybinds
(define-key prog-mode-map
            (kbd "<backtab>") #'company-complete)

(keymap-global-set "C-x C-<up>" 'buffer-menu)
(keymap-global-set "C-x <up>" 'buffer-menu)


;; Package-specific keybinds

(use-package evil
  :config
  (evil-define-key 'visual global-map "S" 'surround-insert)
  (evil-define-key 'insert global-map (kbd "C-@") 'set-mark-command)
  (evil-define-key 'normal global-map (kbd "=") 'pop-global-mark)
  )


(use-package treemacs-mode
  :after (evil)
  :init
  (evil-define-key 'normal treemacs-mode-map (kbd "<TAB>") #'treemacs-TAB-action)
  (evil-define-key 'normal treemacs-mdoe-map (kbd "<RET>") #'treemacs-RET-action)
  )

(use-package rustic
  :after (evil)
  :init
  (evil-define-key 'normal rustic-popup-mode-map (kbd "q") #'delete-window)
  )

;(use-package corfu
;  :config
;  (define-keys corfu-map
;               ((kbd "M-n") #'corfu-next)
;	       ((kbd "<backtab>") #'corfu-previous)
;	       ((kbd "<tab>") #'corfu-next)
;	       ((kbd "M-p") #'corfu-previous)
;	       ((kbd "M-<ret>") #'corfu-insert)
;	       ((kbd "C-c") #'corfu-insert)
;	       ((kbd "<escape>") #'corfu-quit)
;	       ((kbd "M-l") #'corfu-show-location))
;  )

(use-package avy
  :after (evil)
  :config
  (evil-define-key '(list normal motion visual) global-map (kbd "-") 'avy-goto-char)
  (evil-define-key '(list normal motion visual) global-map (kbd "_") 'avy_goto_line))

(use-package ace-window
  :config
  (keymap-global-set "M-o" 'ace-window))

(defvar window-map (define-keymap
                     "h" #'evil-window-left
		     "j" #'evil-window-down
		     "k" #'evil-window-up
		     "l" #'evil-window-right
                     "H" #'window-move-left
		     "J" #'window-move-down
		     "K" #'window-move-up
		     "L" #'window-move-right
		     "v" #'+evil/window-vsplit-and-follow
		     "n" #'+evil/window-split-and-follow
		     "r" #'redraw-display
		     ))
(defvar config-map (define-keymap
		     "r" (lambda () (interactive) (load "~/.emacs.d/init.el"))
		     "h" (lambda () (interactive) (find-file "~/org/contents.org"))
		     "c" (lambda () (interactive) (find-file "~/.emacs.d/init.el"))
		     "k" (lambda () (interactive) (find-file "~/.emacs.d/init.el"))
		     "d" (lambda () (interactive) (dired "./"))
                                        ;"l" (lambda () (interactive) (show-keybinds))
		     ))

(defvar view-map (define-keymap
                   "l" #'lsp-describe-at-point
                   ))

(defvar buffer-map (define-keymap :full t
                     "p" #'previous-buffer
                     "n" #'next-buffer
                     "b" #'buffer-menu
                     ))

(defvar customize-map (define-keymap
		        "c" #'customize-browse
			"f" #'list-faces-display
			"v" #'customize-variable
			"g" #'customize-group
			))

(defvar project-map (define-keymap
		      "t" #'treemacs
		      "e" (lambda () (interactive) (lsp-treemacs-errors-list))
		      "x" #'projectile-compile-project
		      "p" (lambda () (interactive)
			    (projectile-switch-project))
		      "l" #'lsp
		      "v" #'vterm
		      "V" #'multi-vterm
		      "s" (lambda () (interactive)
			    (lsp-treemacs-errors-list)
			    (treemacs)
			    (lsp))
		      ))

(defvar file-map (define-keymap
                   "r" #'recentf
                   "f" #'format-all-buffer
                   ))

(defvar leader-map (define-keymap
                     "." #'find-file
                     "/" #'avy-goto-char-2
                     "b" buffer-map
                     "c" customize-map
                     "d" config-map
                     "f" file-map
                     "h" help-map
                     "p" project-map
                     "v" view-map
                     "w" window-map
                     ))

(use-package org
  :after evil
  :config
  (defvar org-roam-map (define-keymap
                         "l" #'org-roam-node-insert
                         "n" #'org-id-get-create
                         "v" #'org-roam-node-visit
                         ))

  (defun org-insert-latex-block () (interactive)
         (if (texmathp)
             (if (looking-at-p "\\\\)")
                 (forward-char 2)
               (insert "\\)"))
           (progn
             (insert "\\(\\)")
             (backward-char 2))))

  (defun insert-text-block () (interactive)
         (if (texmathp)
             (progn
               (insert "\\text{}")
               (backward-char))
           (if (looking-at-p "}")
               (forward-char 1)
             (insert "}"))
           ))

  (defun quick-matrix () (interactive)
         (insert "\\begin{matrix}\n\n\\end{matrix}")
         (previous-line))

  (defun begin-end-block (text) (interactive)
         (if (texmathp) (next-line 2)
           (progn
             (setq output-string (concat "\\begin{" text "}\n\n\\end{" text "}"))
             (insert output-string)
             (previous-line))))

  (defun create-new-heading () (interactive)
         (end-of-line)
         (org-toggle-heading t)
         (if (>= (prefix-numeric-value current-prefix-arg) 4) () (org-todo))
         (insert "\n")
         (if (>= (prefix-numeric-value current-prefix-arg) 16) () (org-id-get-create)))



  (defvar latex-block-map (define-keymap
                            "t" #'insert-text-block
                            "e" (lambda () (interactive) (begin-end-block "equation*"))
                            "E" (lambda () (interactive) (begin-end-block "equation"))
                            "r" (lambda () (interactive) (begin-end-block "equation"))
                            "i" (lambda () (interactive) (begin-end-block (read-string "Enter the type of block: ")))
                            "a" (lambda () (interactive) (begin-end-block "align*"))
                            "m" #'quick-matrix
                            "k" #'org-insert-latex-block
                            ))


  (define-keys org-mode-map
               ((kbd "C-c C-t") #'org-todo)
               ((kbd "C-c C-h") #'org-toggle-heading)
               ((kbd "C-c C-,") #'org-promote-subtree)
               ((kbd "C-c C-.") #'org-demote-subtree)
               ;((kbd "C-c C-o") org-roam-map)
               ((kbd "C-c ;") #'org-insert-latex-block)
               ((kbd "C-c C-;") latex-block-map)
               ((kbd "C-c C-'") #'create-new-heading)
               ((kbd "C-c C-L") #'insert-link-to-heading)
               ((kbd "M-;") #'org-insert-latex-block)
               ((kbd "M-'") latex-block-map)
               ((kbd "M-[") #'org-insert-latex-block)
               ((kbd "M-#") #'org-roam-node-find)
               ((kbd "M-]") #'org-roam-node-insert)
               )

  (evil-define-key 'insert org-mode-map (kbd "<insert>") #'org-insert-latex-block)
  (evil-define-key 'insert org-mode-map (kbd "S-<insert>") #'insert-text-block)
  (evil-define-key 'insert org-mode-map (kbd "M-<insert>") (lambda () (interactive) (begin-end-block "equation*")))



  (set-local-leader-map org-mode-map "m"
		        "." #'consult-org-heading
		        "l i" #'org-id-get-create
		        "i" #'org-roam-node-insert
		        "f" #'org-roam-node-find
		        "r" #'org-id-reload-all
		        "b" #'org-mark-ring-goto
                        "v" #'org-toggle-narrow-to-subtree
                        "h" (lambda () (interactive) (org-cycle-hide-drawers 'all)))

  (evil-define-key 'normal org-mode-map (kbd "<TAB>") #'org-cycle)
  )
(use-package yasnippet
  :after (org evil)
  :config
  (evil-define-key 'global org-mode-map (kbd "C-c C-s") #'yas-insert-snippet)
  )

(evil-define-key 'normal global-map (kbd "<SPC>") leader-map)
(define-key global-map (kbd "C-c C-SPC") leader-map)
(define-key global-map (kbd "C-c SPC") leader-map)

(provide 'keybinds)
