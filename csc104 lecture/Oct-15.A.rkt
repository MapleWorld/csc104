;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-15.A) (compthink-settings #hash((prefix-types? . #f))))
; Let's continue with comma-separating a list of texts, which will motivate
;  the introduction of the ‘if’ operation.

; We'll fix the problem of the exta ", " at the end, and also put in an "and".

; comma-separate : list → text

(check-expect (comma-separate (list "amy" "bill" "clara" "donna"))
              ; Some people leave out the comma before the "and".
              ; That comma is called the “Oxford Comma”.
              "amy, bill, clara, and donna")

; A special case, which we'll eventually handle:
(check-expect (comma-separate (list "amy" "bill"))
              "amy and bill")

; Recall we made
;   comma-space : text → text

(check-expect (comma-space "amy") "amy, ")

; Full Design:
(check-expect (comma-space "amy") (text-join "amy" ", "))

; Add ", " to the end of a text.
(define (comma-space a-text)
  (text-join a-text ", "))

; We also played around with some list functions:

(check-expect (first (reverse (list "amy" "bill" "clara" "donna")))
              "donna")

(check-expect (reverse (rest (reverse (list "amy" "bill" "clara" "donna"))))
              (list "amy" "bill" "clara"))

; Let's make two functions
;   last : list → any
;   except-last : list → list

(check-expect (last (list "amy" "bill" "clara" "donna"))
              "donna")

; Full Design:
(check-expect (last (list "amy" "bill" "clara" "donna"))
              (first (reverse (list "amy" "bill" "clara" "donna"))))

; The last element of a non-empty list.
(define (last a-list)
  (first (reverse a-list)))

(check-expect (except-last (list "amy" "bill" "clara" "donna"))
              (list "amy" "bill" "clara"))

; Full Design:
(check-expect (except-last (list "amy" "bill" "clara" "donna"))
              (reverse (rest (reverse (list "amy" "bill" "clara" "donna")))))

; The elements of a non-empty list without the last element.
(define (except-last a-list)
  (reverse (rest (reverse a-list))))

; Back to designing comma-separate:

(check-expect (comma-separate (list "amy" "bill" "clara" "donna"))
              (text-join "amy, bill, clara, "
                         "and "
                         "donna"))

(check-expect (comma-separate (list "amy" "bill" "clara" "donna"))
              (text-join "amy, bill, clara, "
                         "and "
                         (last (list "amy" "bill" "clara" "donna"))))

; Recall how we made a version of comma-separate in the last lecture.
(check-expect (apply text-join
                     (map comma-space
                          (list "amy" "bill" "clara")))
              "amy, bill, clara, ")

; We can take that approach for the first three elements, to get a
;  Full Design for lists with at least three elements: 
(check-expect (comma-separate (list "amy" "bill" "clara" "donna"))
              (text-join (apply text-join
                                (map comma-space
                                     (except-last (list "amy" "bill" "clara" "donna"))))
                         "and "
                         (last (list "amy" "bill" "clara" "donna"))))

; This version doesn't handle our special case of two elements.
#;(define (comma-separate a-list)
    (text-join (apply text-join
                      (map comma-space
                           (except-last a-list)))
               "and "
               (last a-list)))

; Let's handle the special case of two elements.

(check-expect (comma-separate (list "amy" "bill"))
              (text-join "amy" " and " "bill"))

; Full Design for lists with two elements:
(check-expect (comma-separate (list "amy" "bill"))
              (text-join (first (list "amy" "bill"))
                         " and "
                         ; We could also use ‘second’, but it's usually best to
                         ;  handle multiple cases as similarly as possible.
                         (last (list "amy" "bill"))))

; Now we need an operation that can choose between two expressions:
#;(if [condition-expression result-expression]
      [else alternative-expression])
; That means:
;   “If the condition-expression is true evaluate the result-expression,
;     or else evaluate the alternative-expression.”

(step (if [(= (+ 1 1) 2) "makes sense"]
          [else "weird"]))
(step (if [(= (+ 1 1) 3) "makes sense"]
          [else "weird"]))
(step (if [(= (+ 1 1) 2) "makes sense"]
          [else (first (list))]))
(step (if [(= (+ 1 1) 3) (first (list))]
          [else "weird"]))

; The parts
#;[condition-expression result-expression]
#;[else alternative-expression]
;  are called “if clauses”, and the one starting with ‘else’ is more specifically
;  called “the else clause”. An if clause contains a pair of expressions, grouped
;  with brackets ‘[]’. The ‘else’ expression is special: it always appears in the
;  else clause, and can't be used anywhere else.

; In our language, paired brackets and paired parentheses are interchangeable, but
;  by convention we use brackets for ‘if’ clauses: it makes the structure more explicit,
;   and emphasizes that the two expressions are not being grouped for a function call.

; Like ‘and’ and ‘or’, the ‘if’ operation takes control of when and whether the
;  component expressions are evaluated. In fact, ‘and’ and ‘or’ can be mimicked
;  with ‘if’, and an ‘if’ expression that produce a boolean can be replaced with
;  an expression that uses ‘and’ and/or ‘or’.

; Now we can write a comma-separate the handles lists with two or more texts:
(define (comma-separate a-list)
  (if [(≥ (length a-list) 3) (text-join (apply text-join
                                               (map comma-space
                                                    (except-last a-list)))
                                        "and "
                                        (last a-list))]
      [else (text-join (first a-list)
                       " and "
                       (last a-list))]))

; The step operation can have a “hide” clause, listing functions to not step into.
; Let's use that to see the steps for comma-separate, but treating the “helper”
;  functions we made as “black boxes” whose details we're not interested in.

(step (hide comma-space last except-last)
      (comma-separate (list "amy" "bill" "clara" "donna")))

(step (hide comma-space last except-last)
      (comma-separate (list "amy" "bill")))
