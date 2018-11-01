;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname quiz-5.practice) (compthink-settings #hash((prefix-types? . #f))))
; Exercises for Quiz 5
; ====================
; The quiz on October 24th will be related to these exercises.

; ★ Draw the result for each of: (a 0) (a 1) (a 2) (a 3).
; Write out any of the steps that you find helpful.

(define (a k)
  (if [(= k 0) (star 10 "solid" "gold")]
      [else (beside (a (- k 1))
                    (star (* 10 (+ k 1)) "solid" "gold"))]))

; To help you understand the process:
#;(step (a 0))
#;(step (hide (a 0))
        (a 1))
#;(step (hide (a 1))
        (a 2))
#;(step (hide (a 2))
        (a 3))


; ★ Draw the result of (S 10) and (S 20).
(define (S side-length)
  (square side-length "outline" "forestgreen"))


; ★ Draw the result for each of: (b 0) (b 1) (b 2) (b 3).
; Write out any of the steps that you find helpful.

(define (b n)
  (if [(> n 0) (above (b (- n 1))
                      (S (* 2 (width (b (- n 1))))))]
      [else (S 10)]))

; To help you understand the process:
#;(step (hide S)
        (b 0))
#;(step (hide S (b 0))
        (b 1))
#;(step (hide S (b 1))
        (b 2))
#;(step (hide S (b 2))
        (b 3))


; ★ Draw the result for each of: (c 0) (c 1) (c 2) (c 3).
; Write out any of the steps that you find helpful.

(define (c i)
  (if [(= i 0) (S 10)]
      [else (beside (above (c (- i 1)) (c (- i 1)))
                    (S (* 10 (+ i 1))))]))

; To help you understand the process:
#;(step (hide S)
        (c 0))
#;(step (hide S (c 0))
        (c 1))
#;(step (hide S (c 1))
        (c 2))
#;(step (hide S (c 2))
        (c 3))


; ★ Draw the result for each of: (d 0) (d 1) (d 2) (d 3).
; Write out any of the steps that you find helpful.

(define (d n)
  (if [(≥ n 1) (overlay (beside (d (- n 1)) (d (- n 1)))
                        (S (width (d (- n 1)))))]
      [else (S 20)]))

; To help you understand the process:
#;(step (hide S)
        (d 0))
#;(step (hide S (d 0))
        (d 1))
#;(step (hide S (d 1))
        (d 2))
#;(step (hide S (d 2))
        (d 3))


; ★ Draw the result for each of: (e 0) (e 1) (e 2) (e 3).
; Write out any of the steps that you find helpful.

(define (e n)
  (if [(= n 0) (S 20)]
      [else (overlay (S (* 2 (width (e (- n 1)))))
                     (counter (beside (e (- n 1)) (e (- n 1)))))]))

; To help you understand the process:
#;(step (hide S)
        (e 0))
#;(step (hide S (e 0))
        (e 1))
#;(step (hide S (e 1))
        (e 2))
#;(step (hide S (e 2))
        (e 3))
