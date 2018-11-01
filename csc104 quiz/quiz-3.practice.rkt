;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname quiz-3.practice) (compthink-settings #hash((prefix-types? . #false))))
; Exercises for Week 4
; ====================
; The quiz on October 3rd will be related to this exercise.

; You should do well on the quiz if you work through this carefully in DrRacket:
;  uncomment and run each expression, or try it in the Interactions. Pay attention
;  to the results, including what any error messages say. And use ‘step’ to see the
;  steps to produce the result.

; Show the steps and final value for each of the following expressions, except the
;  definitions. Always compute inner expressions before outer ones, but it is your
;  choice whether to do that left to right or in parallel.

; If a step produces an error then state that it produces an error and stop evaluating
;  that expression.

(list (+ 1 2 3) (+ 10 20 30) (+ 100 200 300))


; Reminder that you can check your work with step:
#;(step (list (+ 1 2 3) (+ 10 20 30) (+ 100 200 300)))


#;(list (circle 10 "solid" "green") "seven" 3 #false)

#;(length (list 12 34 56))

#;(define L1 (list 0 1 2 3 4))

#;(length L1)

#;(length (range 3 11 2))

#;(length 123456)

#;(length (list (text-join "abc" "def" "ghi")))

#;(length (text-join "rick" "and" "morty"))

#;(length (list (circle 10 "solid" "black") 123 #true (text-join "a" "b" "c")))

#;(length (square 10 "outline" "black"))

#;(length "rick" "and" "morty")

#;(define L2 (list "rick" (text-join "and" "morty"))) 

#;(length L2)

#;(length (map text-length L2))

#;(apply text-join L2)

#;(apply + (map text-length L2))

#;(map text-length "rick" "and" "morty")

#;(map - (list 12 3))

#;(apply - (list 12 3))

#;(apply text-length (text-join "rick" "and" "morty"))

#;(map width (list (triangle 7 "solid" "green") (square 5 "outline" "blue")))

#;(apply above (map flip (list (triangle 10 "solid" "red") (star 10 "outline" "blue"))))

#;(flip (apply above (list (triangle 10 "solid" "red") (star 10 "outline" "blue"))))

#;(define (f n)
    (- n 7))

#;(map f (list 8 9 10))

#;(define (one whatever)
    1)

#;(one "hello")

#;(map one (list 1 0 4))

#;(apply + (map one (list 1 0 4)))
