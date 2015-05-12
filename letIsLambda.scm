;; an example of how let is the same as a lambda expression

(let ((foo 1)
      (bar 2)
      (baz 3))
  (+ foo bar baz))

((lambda (foo bar baz)
   (+ foo bar baz)) 1 2 3)
