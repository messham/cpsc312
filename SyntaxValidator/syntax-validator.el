;; syntax-validator.el --- emacs plugin for SyntaxValidator

(defun syntax-validator ()
  (interactive)
  ;; check that current buffer is cpp file
  (setq cppbuffer (buffer-name))  
  (if (not (string-match "\\.cpp" cppbuffer))
      (error "SyntaxValidator requires a .cpp file!"))
  
  ;; split screen and show eshell
  (split-window-right)
  (next-multiframe-window)
  (eshell)
  (end-of-buffer)
  (eshell-bol)
  (ignore-errors (kill-line))

  ;; open swipl and load syntax-validator
  (setq dir "~/.emacs.d/lisp/syntaxvalidator/")
  (insert (concat "cd " dir))
  (eshell-send-input)
  (insert "swipl")
  (eshell-send-input)
  (insert "[syntax].")
  (eshell-send-input)
  (insert-buffer cppbuffer)
  (end-of-buffer)
  )

(provide 'syntax-validator)

;; syntax-validator.el ends here
