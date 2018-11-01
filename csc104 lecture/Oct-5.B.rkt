;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-5.B) (compthink-settings #hash((prefix-types? . #f))))
; Let's make a unary function that takes a list of texts and produces a text with the elements
;  separated by ", " [aka “comma separated”].

; In lecture, after working on this a bit we reconsidered the goal, viewing it as having
;  two components:
;   1. Put a ", " after each element.
;   2. Avoid or remove ", " after the last element.
; This is a common problem-solving technique: break down a problem into separate problems,
;  solve those simpler problems, and then try to combine the solutions.

; Here we'll focus on putting ", " after each element.

; Documentation and correctness:
(check-expect (comma-separated (list "amy" "bill" "clara" "donna"))
              "amy, bill, clara, donna, ")

; The contract for the function we're making is
;   comma-separated : list -> text

; Partial Design:
(check-expect (comma-separated (list "amy" "bill" "clara" "donna"))
              (text-join "amy, "
                         "bill, "
                         "clara, "
                         "donna, "))

; There is a repeated computation there: add ", " to the end of a text. Always consider
;  making a function (after checking whether there already is one) whenever there is a
;  repeated computation. So let's make a function to add ", " to the end of a text.

; Documentation / correctness:
(check-expect (comma-space "amy") "amy, ")
; Full Design:
(check-expect (comma-space "amy") (text-join "amy" ", "))

; comma-space : text -> text
(define (comma-space a-text)
  (text-join a-text ", "))

; Closer to a Full Design:
(check-expect (comma-separated (list "amy" "bill" "clara" "donna"))
              (text-join (comma-space "amy")
                         (comma-space "bill")
                         (comma-space "clara")
                         (comma-space "donna")))

; That should look and feel familiar, reminding you of map. Notice:
(check-expect (map comma-space (list "amy" "bill" "clara" "donna"))
              (list (comma-space "amy")
                    (comma-space "bill")
                    (comma-space "clara")
                    (comma-space "donna")))

; Then apply can take the transformed list and combine the elements.
(check-expect (apply text-join (list (comma-space "amy")
                                     (comma-space "bill")
                                     (comma-space "clara")
                                     (comma-space "donna")))
              (text-join (comma-space "amy")
                         (comma-space "bill")
                         (comma-space "clara")
                         (comma-space "donna")))

; That inspires a Full Design:
(check-expect (comma-separated (list "amy" "bill" "clara" "donna"))
              (apply text-join (map comma-space (list "amy" "bill" "clara" "donna"))))

; comma-separated : list -> text
(define (comma-separated texts)
  (apply text-join (map comma-space texts)))
