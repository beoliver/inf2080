(define (lookup-in-frames k frames)
  (call-with-current-continuation
    (lambda (return)
      (for-each (lambda (frame)
        (let ((pair (assoc k frame)))
          (if pair (return pair))))
      frames) #f)))

(define (define-variable! key val frames)
  ;; #{Unspecific} return value
  ;; only changes the local frame (ie the car of frames)
  (let ((pair (assoc key (car frames))))
    (if pair
      (set-cdr! pair val)
      (set-car! frames (cons (cons key val) (car frames))))))

(define (meta-eval expr env)
  (cond ((number? expr) expr)
        ((symbol? expr) (cdr (lookup-in-frames expr env)))
        ((lambda? expr) (make-procedure expr env))
        ((define? expr) (define-variable! (cadr expr) (meta-eval (caddr expr) env) env))
        ((application? expr) 
          (meta-apply 
            (meta-eval (car expr) env) 
            (map (lambda (x) (meta-eval x env)) (cdr expr))))
        (else "error")))

(define (meta-apply proc args)
  (cond ((primitive-procedure? proc) (apply-primitive-procedure proc args))
        ((compound-procedure? proc) 
          (let* ((new-frame (map cons (procedure-parameters proc) args))
                (extended-env (cons new-frame (procedure-environment proc))))
                (eval-sequence (procedure-body proc) extended-env)))
        (else "error")))

(define (eval-sequence exps env) ;; only last value is returned
  (if (null? (cdr exps))
      (meta-eval (car exps) env)
      (begin (meta-eval (car exps) env)
  	     (eval-sequence (cdr exps) env))))

(define (make-procedure exp env)
  (let ((parameters (cadr exp))
	(body (cddr exp)))
    (list 'procedure parameters body env)))

(define (application? exp) (pair? exp))

(define (compound-procedure? exp)
  (and (list? exp) (eq? 'procedure (car exp))))

(define (primitive-procedure? exp)
  (and (list? exp) (eq? 'primitive (car exp))))

(define (lambda? exp)
  (and (list? exp) (eq? 'lambda (car exp))))

(define (define? exp)
  (and (list? exp) (eq? 'define (car exp))))

(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-environment p) (cadddr p))

(define env (list '()))



;; 18> (meta-eval '(define cons (lambda (a b) (lambda (p) (p a b)))) env)
;; #{Unspecific}
;; 18> (meta-eval '(define car (lambda (p) (p (lambda (a b) a)))) env)
;; #{Unspecific}
;; 18> (meta-eval '(car (cons 1 2)) env)
;; 1
