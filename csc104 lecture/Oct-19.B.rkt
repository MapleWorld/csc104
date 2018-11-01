;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-19.B) (compthink-settings #hash((prefix-types? . #f))))
; Sifting
; =======

; To select only certain records from our database we'll use the function ‘sift’,
;  which takes a unary function producing a boolean, and a list, and produces
;  the list of elements for which the function produces #true. First let's explore
;  it with relatively simple functions and lists.

; For example, to extract only the texts from a list:
(sift text? (list 12 "orange" 345 678 "pineapple" "pear" 90))

; Or only the numbers:
(sift number? (list 12 "orange" 345 678 "pineapple" "pear" 90))

; Or only the images:
(sift image? (list 12 "orange" 345 678 "pineapple" "pear" 90))

; Sifting is similar to mapping: it calls the function one each element individually.
; But sifting doesn't collect the results, instead it keeps the elements that produce
;  the particluar result #true.
(check-expect (map text? (list 12     "orange" 345    678    "pineapple" "pear" 90))
              (list            #false #true    #false #false #true       #true  #false))
; The elements that sift would produce are exactly the ones that produces the three #trues.

; The contract for sift is : function list → list .
; A function that produces a boolean is called a “predicate”, so more precisely the
;  contract for sift is : unary-predicate list → list .

; A value for which a predicate produces #true is said to “satisfy” the predicate.
; So sift takes a unary predicate and a list, and produces a list of the elements
;  which satisfy the predicate.

; Some Unary Numeric Predicates, and Random Numbers
; =================================================
; The functions zero?, positive?, and negative? determine whether a number is zero,
;  positive, or negative.
(check-expect (zero? 0) #true)
(check-expect (zero? 10) #false)
(check-expect (sift zero? (list 0 12 30 4 0)) (list 0 0))

; To make more interesting examples, let's use the unary function ‘random’: it takes a
;  positive natural number and randomly produces a natural number less than that number.
(define r (random 3)) ; r is one of the three numbers 0, 1, or 2.
(check-expect (or (= r 0) (= r 1) (= r 2)) #true)

(random 10) ; randomly: 0, 1, 2, 3, ..., or 9
(random 10)
(random 10)
(random 10)

(random 2) ; randomly: 0 or 1
(random 2)
(random 2)
(random 2)
(random 2)
(random 2)

(zero? (random 2)) ; 50% chance of being true, since (random 2) produces 0 or 1.
(zero? (random 2))
(zero? (random 2))
(zero? (random 2))
(zero? (random 2))
(zero? (random 2))

; The list of 0s from a random list of 6 0s or 1s:
(sift zero? (map random (list 2 2 2 2 2 2)))
(sift zero? (map random (list 2 2 2 2 2 2)))
(step (sift zero? (map random (list 2 2 2 2 2 2))))

(sift positive? (map random (list 2 2 2 2 2 2)))

; No negative numbers though:
(check-expect (sift negative? (map random (list 2 2 2 2 2 2))) (list))

; The negative numbers from a random list of 0s and -1s:
(sift negative? (map - (map random (list 2 2 2 2 2 2))))

; There are also predicates for determining whether a whole number is even or odd.

; The even numbers from a random list of natural numbers all less than 100:
(sift even? (map random (list 100 100 100 100 100 100)))

(sift odd?  (map random (list 100 100 100 100 100 100)))
