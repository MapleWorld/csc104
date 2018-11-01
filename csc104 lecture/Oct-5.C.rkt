;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-5.C) (compthink-settings #hash((prefix-types? . #f))))
; Some More List Functions

; For comma-separate to handle the last element specially, we'll need some functions that
;  extract parts of a list.

; The functions
;   first  : list -> any
;   second : list -> any
;   third  : list -> any
;   fourth : list -> any
;  produce the first, second, third, and fourth element of a list.

(check-expect (first  (list "amy" "bill" "clara" "donna")) "amy")
(check-expect (second (list "amy" "bill" "clara" "donna")) "bill")
(check-expect (third  (list "amy" "bill" "clara" "donna")) "clara")
(check-expect (fourth (list "amy" "bill" "clara" "donna")) "donna")

; Mapping and applying handle many list processing tasks, but sometimes we will process
;  a single element, and then the rest. The function
;   rest : list -> list
;  takes a non-empty list and produces a version without the first element.
(check-expect (rest (list "amy" "bill" "clara" "donna"))
              (list "bill" "clara" "donna"))

; For comma-separate we would like to handle the last element of a list specially.
; Instead of having analogous functions such as ‘last’, ‘second-last’, ‘third-last’ etc,
;  our language has a function to reverse the order of the elements of a list
;   reverse : list -> list

; That lets us “translate” our problem to be about the first element of a list.
(check-expect (reverse (list "amy" "bill" "clara" "donna"))
              (list "donna" "clara" "bill" "amy"))

; The last element of a list is the first element of the reversed list:
(check-expect (first (reverse (list "amy" "bill" "clara" "donna")))
             "donna")

; The rest of the elements is then:
(check-expect (rest (reverse (list "amy" "bill" "clara" "donna")))
              (list "clara" "bill" "amy"))

; We will need those in their original order, so we reverse that result:
(check-expect (reverse (rest (reverse (list "amy" "bill" "clara" "donna"))))
              (list "amy" "bill" "clara"))

; This illustrates another powerful general technique for problem solving: translate
; a problem to a context where you know how to solve it, and then if necessary translate
;  the solution back to the original context.
