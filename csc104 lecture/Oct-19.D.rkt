;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-19.D) (compthink-settings #hash((prefix-types? . #f))))
; Two More List Functions : join and adjoin
; -----------------------------------------

; A list containing three lists:
(list (list "ant" "bee") (list "cat" "dog" "eel") (list "fly"))

(check-expect (length (list (list "ant" "bee") (list "cat" "dog" "eel") (list "fly")))
              3)

; The function ‘join’ takes any number of lists and produces one list with all their elements.
; join : list ... → list

(check-expect (join (list "ant" "bee") (list "cat" "dog" "eel") (list "fly"))
              (list "ant" "bee" "cat" "dog" "eel" "fly"))

; For a single list, it just produces the list:
(check-expect (join (list "ant" "bee"))
              (list "ant" "bee"))

; Given no arguments, it produces the empty list:
(check-expect (join) (list))

; What will this produce:
#;(join (list (list "ant" "bee") (list "cat" "dog" "eel") (list "fly")))

; If we want to join lists that are inside a list, we can apply:
(apply join (list (list "ant" "bee") (list "cat" "dog" "eel") (list "fly")))

; The arguments must be lists. For example, this produces an error:
#;(join "owl" (list "ant" "bee" "cat" "dog" "eel" "fly"))

; If we want to add an element to a list, we can put it into its own list first:
(check-expect (join (list "owl") (list "ant" "bee" "cat" "dog" "eel" "fly"))
              (list "owl" "ant" "bee" "cat" "dog" "eel" "fly"))

; That is common enough that we have a function in our language for to do that.
; adjoin : any list → list
(check-expect (adjoin "owl" (list "ant" "bee" "cat" "dog" "eel" "fly"))
              (list "owl" "ant" "bee" "cat" "dog" "eel" "fly"))

