;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname quiz-4.practice) (compthink-settings #hash((prefix-types? . #f))))
; Exercises for Quiz 4
; ====================
; The quiz on October 17th will be related to this exercise.

; Examine this function definition.
; f : number → boolean
(define (f n)
  (or (= n 0)
      (and (> n 0)
           (f (- n 2)))))

; Show the steps to evaluate the following expressions:
#;(f -1)
#;(f  0)

; Show the steps to evaluate the following expression.
; If the steps involve (f -1) or (f 0), you may simply use the values you already calculated,
;  instead of showing their steps again.
#;(f 1)

; The step operation can be told to hide the steps for particular function calls.
; For example, the following expression shows the steps for (f 1), omitting any steps for
;  (f -1) or (f 0) if they occur:
#;(step (hide (f -1) (f 0))
        (f 1))

; Show the steps to evaluate the following expressions.
; If the steps involve expressions you already stepped, you may simply use the values you already
;  calculated instead of showing those steps again.
#;(f 2)
#;(f 3)

; Here are the corresponding step expressions, to check your work:
#;(step (hide (f -1) (f 0) (f 1))
        (f 2))
#;(step (hide (f -1) (f 0) (f 1) (f 2))
        (f 3))
