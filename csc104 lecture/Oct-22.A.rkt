;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-22.A) (compthink-settings #hash((prefix-types? . #f))))
; Local Definitions
; =================

; We had a database containing birth-years, and sifted it for all the records
;  of people born after 1905, by defining an appropriate predicate. If we want
;  a list of the people born after, for example, 1906 we need to define another
;  predicate. What we will see now is a way to programmatically generate these
;  definitions.

; For this we'll need a new operation : local.
; It has the form:
#;(local [a-definition
          ...]
    an-expression)

; For example:
(local [(define a "ant")] ; Temporarily make a definition, only accessible “locally”
  ; The definitions are usable by the expression:
  (text-join a "!"))

; The local variable is not accessible outside the expression.
#;a ; This would be an error.

; We can group more than one definition:
(local [(define a "ant")
        (define ending "!")]
  (text-join a ending))

(step (local [(define a "ant")
              (define ending "!")]
        (text-join a ending)))

; The non-local definitions we've made earlier in the course are called “global” definitions.
(define a "aardvark")

; A local variable with the same name as a global one takes precedence:
(check-expect (local [(define a "ant")
                      (define ending "!")]
                (text-join a ending))
              "ant!")

; But if there is no local version, the global version still gets used:
(check-expect (local [(define b "ant")
                      (define ending "!")]
                (text-join a ending))
              "aardvark!")

; If there is any computation needed to determine the variable values, that happens first:
(step (local [(define a "ant")
              (define ending (text-join "eater" "!"))]
        (text-join a ending)))


; We can also locally define functions.
(step (local [(define (above-50? x)
                (> x 50))]
        (above-50? 67)))

(local [(define (above-50? x)
          (> x 50))]
  (above-50? 67))

; Let's change the body, but not the name:
(local [(define (above-50? x)
          (> x 500))]
  (above-50? 67))

; Let's sift using a locally defined function.
(step (local [(define (above-50? x)
                (> x 50))]
        (sift above-50? (list 123 45 67 890))))

; Let's change the body again:
(step (local [(define (above-50? x)
                (> x 500))]
        (sift above-50? (list 123 45 67 890))))

; Let's make the lower bound more explicit, and change the function name to be clearer:
(local [(define lower-bound 50)
        (define (above-bound? x)
          (> x lower-bound))]
  (sift above-bound? (list 123 45 67 890)))

; With a different bound:
(local [(define lower-bound 500)
        (define (above-bound? x)
          (> x lower-bound))]
  (sift above-bound? (list 123 45 67 890)))
