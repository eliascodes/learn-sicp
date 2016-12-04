; Exercise 1.15.

; The sine of an angle (specified in radians) can be computed by making use of
; the approximation sin(x) = x if x is sufficiently small, and the trigonometric
; identity
;
;   sin(r) = 3 sin(r / 3) - 4 (sin(r / 3))^3
;
; to reduce the size of the argument of sin. (For purposes of this exercise an
; angle is considered ``sufficiently small'' if its magnitude is not greater
; than 0.1 radians.) These ideas are incorporated in the following procedures:

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

; a.  How many times is the procedure p applied when (sine 12.15) is evaluated?
;
; The angle is recursively reduced by dividing by three until it has a magnitude
; less than 0.1. If the angle is reduced n times, the procedure p is applied n-1
; times.
;
; 12.15 / 3 = 4.05 (1)
; 4.05 / 3 = 1.35  (2)
; 1.35 / 3 = 0.45  (3)
; 0.45 / 3 = 0.15  (4)
; 0.15 / 3 = 0.05  (5)
;
; So p is applied 4 times.

; b.  What is the order of growth in space and number of steps (as a function of
;     a) used by the process generated by the sine procedure when (sine a) is
;     evaluated?
;
; The sine procedure calls itself once at each step, and therefore it is a
; linear recursive process. The number of steps are determined by how many times
; one needs to divide a by three for the result to be strictly less than the
; magnitude threshold (in this case 0.1). This is given by the expression
;
;   n(a) = ceil( log_3 ( a / 0.1 ) )
;
; The orders of growth for both steps and space are therefore both O(n(a)), or
; more crudely, O(log a).

(define (logn n x)
  (/ (log x) (log n)))

(define (nsteps a e)
  (ceiling (logn 3 (/ (abs a) e))))

; prints Value: 5
(nsteps 12.15 0.1)
