;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Nov-23.B) (compthink-settings #hash((prefix-types? . #f))))
; Strengthening the Recursion
; ===========================
; If we try to make a recursive function achieve more (“stronger”), i.e. solve a harder problem,
;  that can sometimes make it easier to write, or, as in the case of fib, easier to speed up.
;  This may seem counter-intuitive, but keep in mind that for recursive functions, one of the
;  users of the function is itself. Achieving more in the recursive calls can then be a benefit.
;
; In Mathematical proofs by Induction this is called “Strengthening the Inductive Hypothesis”.
; Much of Computer Science is mathematical, and, in particular, proofs about the properties of
;  programs are usually proofs by Induction.

; Let's make fib stronger by having it produce more information:
;   fib : natural-number → list-of-natural-numbers
;  (fib n) produces the fibonacci sequence, in reverse, up to and including n.
(check-expect (fib 0) (list 1))
(check-expect (fib 1) (list 1 1))
(check-expect (fib 2) (list 2 1 1))
(check-expect (fib 3) (list 3 2 1 1))
(check-expect (fib 4) (list 5 3 2 1 1))

; Design for n ≥ 2.
#;(≥ 5 2)
(check-expect (fib 5) (list (+ 5 3) 5 3 2 1 1))

; Paying careful attention to how I created that result, I notice it was by:
;   • copy-pasting (fib 4)
;   • inserting an element: the sum of the first and second elements of (fib 4)

; Full Design for n ≥ 2:
(check-expect (fib 5) (adjoin (+ (first (fib (- 5 1))) (second (fib (- 5 1)))) (fib (- 5 1))))

; That might seem worse than before, since it has three recursive calls now. And all the calls
;  are for n - 1 (rather than one call being the slightly less work of doing (fib (- n 2))).
;  But all the repeated work is now explicit in a single expression, rather than scattered
;  across calls with different arguments: so we have more control. The key is to make the
;  recursive call once, and use the value three times.

(define (fib n)
  (if [(≥ n 2) (local [(define fib-previous (fib (- n 1)))]
                 (adjoin (+ (first fib-previous)
                            (second fib-previous))
                         fib-previous))]
      ; The following can be simplified, but in this form we see what is special, and what isn't,
      ;  about the cases 0 and 1:
      [(= n 1) (adjoin 1 (fib 0))]
      [else (adjoin 1 (list))]))

; In our language, and most other programming languages, variables name values not expressions.
;  We are relying on that, so that each reference to fib-previous references the stored result,
;  not the expression (fib (- n 1)). In particular, referencing fib-previous doesn't recompute it.

(fib 30)
(first (fib 100))
(time (first (fib 1000)))
(time (first (fib 10000)))

; When our functions and operations don't produce side-effects, computation is “algebraic”.

; Algebras have rules about which transformations of an expression preserves its value.
;  Performing the rules on an expression (replacing expressions with expressions denoting
;  the same value) to produce a literal value always produces the same value --- regardless
;  of which rules are used when. In particular, replacing a sub-expression with its known
;  literal value can't affect the result. But which rules are used when, and which results
;  we remember, can affect how long, and how much paper, we take. So for fib, naming the
;  value of (fib (- n 1)) and using the name can't affect the result, it can only affect
;  the amount of time and memory used.
