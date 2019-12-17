;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname repeats.practice) (compthink-settings #hash((prefix-types? . #f))))
; Practice: repeats
; =================

(define (D x)
  (* 2 x))

; Show these steps:
#;(step [hide D]
        (repeats D 3 4))

; Show the result for:
#;(repeats D 1 5)

(define (T1 n)
  (triangle n "outline" "black"))

(define ds (repeats D 3 4))

; Show these steps:
#;(step [hide T1 D]
        (map T1 (map D ds)))

; ---

; There is a function
;   identity : any → any
;  in our language.

; Its definition is:
#;(define (identity v)
    v)

; For example:
(check-expect (identity 104) 104)
(check-expect (identity (list "cashew" (< 1 2))) (list "cashew" #true))

; That may seem like a silly function, but it is actually important in Math and CS.
; For a taste of its usefulness, show the result for:
#;(apply * (repeats identity 2 5))

; ---

(define (F x)
  (+ 5 x))
 
(define (C i)
  (cut-right i 10))
 
(define (T2 n)
  (clockwise (triangle n "solid" "black")))

(define s (square 30 "solid" "black"))

; Show the first step of, and final result, for:
#;(step [hide F]
        (repeats F 15 4))

; Show the first TWO steps of, and final result, for:
#;(step [hide C]
        (repeats C s 3))

(define fs (repeats F 15 4))

; Show these steps:
#;(step [hide C T2]
        (map C (map T2 fs)))

; ---

(define (FN ab)
  (list (second ab)
        (+ (first ab) (second ab))))

; Show these steps:
#;(step [hide FN]
        (repeats FN (list 0 1) 4))

; Show the result for:
#;(map first (repeats FN (list 0 1) 7))

; ---

(define (CN n)
  (if [(even? n) (/ n 2)]
      [else (inc (* 3 n))]))

; Show the result for:
#;(repeats CN 5 7)

(define (H n)
  (rectangle 5 (* 5 n) "outline" "black"))

(define cs (repeats CN 5 7))

; Show these steps:
#;(step [hide H]
        (map H cs))
