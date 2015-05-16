
(define some-global-var 0)

(define (delayed-mutation x)
  (lambda ()
    (set! some-global-var x)))


;; REPL...
> some-global-var
0
> ; no values returned
> (define f (delayed-mutation 10))
; no values returned
> f
#{procedure 8634 (unnamed in delayed-mutation)}
> some-global-var
0
> (f)
#{Unspecific}
> some-global-var
10
> 
