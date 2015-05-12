;; an example of how let is the same as a lambda expression

(let ((foo 1)
      (bar 2)
      (baz 3))
  (+ foo bar baz))

((lambda (foo bar baz)
   (+ foo bar baz)) 1 2 3)


(define (foo-1 x)
  (let ((two-x (+ x x)))
    (+ x two-x)))

;; is just a nicer way of writing 
  
(define (foo-2 x)
  ((lambda (two-x)
     (+ x two-x)) 
   (+ x x)))

;; which in turn is just syntactic sugar for:

(define foo-3
  (lambda (x)
    ((lambda (two-x)
       (+ x two-x)) 
     (+ x x))))

;; foo-1, foo-2 and foo-3 all do EXACTLY the same thing
