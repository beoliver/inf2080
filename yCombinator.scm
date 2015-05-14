(define x 5)

((lambda (f) (f f)) (lambda (f)
                      (if (not (= 0 x))
			                    (begin 
			                      (display x)
			                      (newline)
			                      (set! x (- x 1))
			                      (f f))
			                    'ok)))

