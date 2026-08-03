
(defun +evil/window-split-and-follow()
  "Split current window horizontally, then focus on new window.
   If `evil-split-window-below` is non-nil, the new window isn't focused."
  (interactive)
  (let ((evil-split-window-below (not evil-split-window-below)))
    (call-interactively #'evil-window-split)))

(defun +evil/window-vsplit-and-follow()
  "Split current window vertically, then focus on new window.
   If `evil-split-window-below` is non-nil, the new window isn't focused."
  (interactive)
  (let ((evil-vsplit-window-right (not evil-vsplit-window-right)))
    (call-interactively #'evil-window-vsplit)))



(defun org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
	     (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
	     (beg (if globalp
		      (point-min)
		    (point)))
	     (end (if globalp
		      (point-max)
		    (if (eq state 'children)
			(save-excursion
			  (outline-next-heading)
			  (point))
		      (org-end-of-subtree t)))))
	(goto-char beg)
	(while (re-search-forward org-drawer-regexp end t)
	  (save-excursion
	    (beginning-of-line 1)
	    (when (looking-at org-drawer-regexp)
	      (let* ((start (1- (match-beginning 0)))
		     (limit
		      (save-excursion
			(outline-next-heading)
			(point)))
		     (msg (format
			   (concat
			    "org-cycle-hide-drawers:  "
			    "`:END:`"
			    " line missing at position %s")
			   (1+ start))))
		(if (re-search-forward "^[ \t]*:END:" limit t)
		    (outline-flag-region start (line-end-position) t)
		  (user-error msg))))))))))


(defun reload-all-keybinds()
  (interactive)
  (load-file "~/.emacs.d/keybinds.el"))


(provide 'functions)
