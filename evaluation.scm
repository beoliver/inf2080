
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

(define x 1)

(list x 
  (begin 
    (set! x (+ x x)) 
    x) 
  (begin 
    (set! x (- x 1)) 
    x))
    
;; => (1 2 1)
