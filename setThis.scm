(define x 
  (lambda () 
    ((lambda () (set! x 10)))))
    

> x
#{procedure 8636 x}
> (x)
#{Unspecific}
> x
10
