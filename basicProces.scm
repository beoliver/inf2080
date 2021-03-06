
(define lookup-in-frames
  (lambda (k frames)
    (call-with-current-continuation
      (lambda (return)
        (for-each
          (lambda (frame)
            (let ((pair (assoc k frame)))
              (if pair (return pair))))
          frames)
    	#f))))

(define define-binding!
  ;; #{Unspecific} return value
  ;; only changes the local frame (ie the car of frames)
  (lambda (key val frames)
    (let ((pair (assoc key (car frames))))
      (if pair
        (set-cdr! pair val)
        (set-car! frames (cons (cons key val) (car frames)))))))

(define set-binding!
  ;; #{Unspecific} return value
  ;; will update the FIRST MATCH then exit
  (lambda (key val frames)
    (call-with-current-continuation
     (lambda (return)
       (for-each (lambda (frame)
                    (let ((pair (assoc key frame)))
                      (if pair
                        (begin
                          (set-cdr! pair val)
                          (return)))))
                  frames)))))
