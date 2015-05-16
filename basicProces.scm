
(define lookup ;; #{Unspecific} return value if not in frames
  (lambda (key frames)
    (call-with-current-continuation
      (lambda (return)
        (for-each 
          (lambda (frame)
            (let ((pair (assoc key frame)))
              (if pair (return (cdr pair)))))
          frames)))))


(define update-local-bindings! ;; #{Unspecific} return value
  (lambda (key-val frames)
    (let ((pair (assoc (car key-val) (car frames))))
      (if pair
	      (set-cdr! pair (cdr key-val))
	      (set-car! frames (cons key-val (car frames)))))))

