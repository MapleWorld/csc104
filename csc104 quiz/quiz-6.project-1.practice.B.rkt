;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname quiz-6.project-1.practice.B) (compthink-settings #hash((prefix-types? . #f))))
; Read the following function definitions.

(define (f s)
  (character s 0))

(define (g n)
  (character "cat" n))

(define (F texts n)
  (local [(define (f s)
            (character s n))]
    (apply text-join (map f texts))))

(define (G a-text)
  (local [(define (g n)
            (character a-text n))]
    (map g (range 0 (text-length a-text) 1))))

(define (brightness pixel)
  (apply + pixel))

(define (t pixel)
  (if [(> (brightness pixel) 7) (list 0 0 0)]
      [else pixel]))

(define (T pixels larger/smaller threshold)
  (local [(define (t pixel)
            (if [(larger/smaller (brightness pixel) threshold) (list 0 0 0)]
                [else pixel]))]
    (map t pixels)))

; ★ Show the following steps:

#;(step (f "elf"))
#;(step (f "dog"))

#;(step (hide f)
        (map f (list "elf" "dog" "fox" "gnu")))

#;(step (hide f)
        (F (list "elf" "dog" "fox" "gnu") 1))

#;(step (g 0))
#;(step (g 1))

#;(step (hide g)
        (map g (list (range 0 (text-length "cat") 1))))

#;(step (hide g)
        (G "dog"))

#;(step (brightness (list 0 3 5)))

#;(step (hide brighntess)
        (t (list 0 3 5)))
#;(step (hide brightness)
        (t (list 1 2 3)))

#;(steps (hide t)
         (T (list (list 1 9 2) (list 3 3 3) (list 3 4 5)) > 10))
