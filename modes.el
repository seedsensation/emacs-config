(make-variable-buffer-local
 (defvar university-org-mode nil
   "Toggle university-org-mode."))

(defvar university-org-mode-map (make-sparse-keymap)
  "The keymap for university-org-mode.")

(add-to-list 'minor-mode-alist '(university-org-mode " university"))
(add-to-list 'minor-mode-map-alist (cons 'university-org-mode university-org-mode-map))

(defun university-org-mode (&optional ARG)
  (interactive (list 'toggle))
  (setq university-org-mode
        (if (eq major-mode 'org-mode) (if (eq ARG 'toggle)
                                          (not university-org-mode)
                                        (> ARG 0)) nil
                                        ))

  (if (eq major-mode 'org-mode)
      (if university-org-mode
          (message "Enabled University org mode!")
        (message "Disabled University org mode!"))
    (message "This mode is only intended for use with org-mode.")))

(provide 'modes)
