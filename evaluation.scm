
(define x 1)

(+ x 
  (begin 
    (set! x 2)
    x) 
  (begin 
    (set! x 3) 
    x))

;; => 6

;; evaluates from left to right
;; for every expression that is passed as an argument
;; it is evaluated and then then passed to the procedure 'list
;; if every arg was evaluated before calling 'list
;; then the result would be '(1 1 1)


(define x 1)

(list x 
      (begin (set! x (+ x x)) x) 
      (begin (set! x (- x 1)) x))

;; => (1 2 1)

(define scheme-list
  (lambda args
    (if (null? args)
	  '()
	  (cons (car args) (apply scheme-list (cdr args))))))

(scheme-list x 
	     (begin (set! x (+ x x)) x) 
	     (begin (set! x (- x 1)) x))

;; => (1 2 1)
