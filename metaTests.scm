;; (car (cons 1 2))
((lambda (xy)
   (xy (lambda (x y) x)))
 ((lambda (x y)
    (lambda (selector)
      (selector x y))) 1 2))

;; (cdr (cons 1 2))
((lambda (xy)
   (xy (lambda (x y) y)))
 ((lambda (x y)
    (lambda (selector)
      (selector x y))) 1 2))
