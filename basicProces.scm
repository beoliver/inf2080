
(define lookup ;; #{Unspecific} return value if not in frames
  (lambda (key frames)
    (call-with-current-continuation
      (lambda (return)
        (for-each 
          (lambda (frame)
            (let ((pair (assoc key frame)))
              (if pair (return (cdr pair)))))
          frames)))))



