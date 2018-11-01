;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname quiz-6.project-1.practice.A) (compthink-settings #hash((prefix-types? . #f))))
; Quiz 6 and Project 1 Practice, Part 1
; =====================================

; Explore the function ‘element?’
; -------------------------------

; A. What error does this following produce:
#;(element?)

; element? : expects two arguments, but received none




; B. Based on the error in part A, why would I try the following expression:
#;(element? 1 2)

; element? : expects a list for the second argument, but received 2



; C. Based on the error you get when you try the expression from part B,
;     why would I try an expression with the following form:
#;(element? 1 ___)

; Should try using a list, because that is what it is expecting



; D. Replace the ‘___’ in the expression from part C so it doesn't produce an error.
(element? 1 (list 1))



; E. Find the description for ‘element?’ in the csc104 language documentation.
; Is e an element of the list l? Returns a boolean



; F. Replace ‘___’ in the following check-expects so that they pass:
#;(check-expect (element? 123 (list 123)) #true)
#;(check-expect (element? 123 (list "123")) #false)

; Design a function that uses ‘element?’
; --------------------------------------

(define zoo (list "eel" "fly" "bee"))

; Here are some tests for a unary predicate zoo-animal? : any → boolean .
; The predicate determines whether a value is in the zoo list.
#;(check-expect (zoo-animal? "fly") #true)
#;(check-expect (zoo-animal? "dog") #false)
#;(check-expect (zoo-animal? "eel") #true)

; Write a full Design check-expect for zoo-animal?, using the zoo list:

; Don't know what full design means yet, need to look it out and read the lecture


; Define zoo-animal? accordingly:
(define (zoo-animal? item)
  (element? item zoo))


; Use the function ‘zoo-animal?’
; ------------------------------

(define animals (list "ant" "bee" "cat" "dog" "eel"))

; For each of the following check-expects, replace ‘animals’ with an
;  expression that uses ‘animals’ and makes the check-expect pass:

#;(check-expect (map zoo-animal? animals)
              (list #false  #true #false  #false  #true))

(define (filter bool item)
  (if [(same? bool #true) item] [else ""]))


#;(check-expect (remove "" (map filter (map zoo-animal? animals) animals))
              (list #;"ant" "bee" #;"cat" #;"dog" "eel"))










