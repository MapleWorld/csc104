;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-26.A) (compthink-settings #hash((prefix-types? . #f))))
; Iteration
; =========

; Repeating a process, updating a value or values, is called “iteration”,
;  also known as “looping”. It's a common special case of the repetition
;  that can be achieved via recursion, and our language has a function to
;  express it more directly: repeats.

; The list of values, starting with 2, and calling squared repeatedly,
;  until there are a total of 5 elements:
(check-expect (repeats squared 2 5)
              (list 2
                    (squared 2)
                    (squared (squared 2))
                    (squared (squared (squared 2)))
                    (squared (squared (squared (squared 2))))))
(check-expect (repeats squared 2 5)
              (list 2
                    4
                    16
                    256
                    65536))
; Let's watch that:
(step (repeats squared 2 5))

; The contract for ‘repeats’ is:
;   repeats : unary-function any natural-number → list

; The algebraic step for it is:
#;(repeats f seed n) ; The initial value is often called a “seed”.
;   →
#;(list seed (f seed) (f (f seed)) (f (f (f seed))) ...) ; where the length is n.

; Because f is called on a result of calling f, we need a function that produces
;  values that can be given back to the function, in particular if the function
;  requires a certain type, it must produce values of that type.

; Recall:
;   not : boolean → boolean
; So we can repeatedly call ‘not’, starting with a boolean.
(repeats not #false 4)

; What are some  list → list  functions we have?
(repeats rest    (list "argon" "boron" "calcium") 3)
(repeats reverse (list "argon" "boron" "calcium") 4)

; How about some  image → image functions?
(repeats flip    (star 75 "solid" "orange") 5)
(repeats counter (star 75 "solid" "orange") 5)

; The big-bang operation in our language can animate a repeated transformation of an image.
; It is not a function. In particular, it has a special form [recall that we've seen two
;  other operations with special forms: ‘define’ and ‘if’].

; The following will pop up a window, and display a star, the star flipped, that flipped, etc.
; Close that window to continue to the rest of this file.
(big-bang (star 75 "solid" "orange") ; “seed” aka “initial value” aka “initial state”
  ; A big-bang ‘on-tick’ clause is the word ‘on-tick’ grouped with a function to repeat
  ;  “on each tick” of the clock [up to 30 times per second].
  [on-tick flip]
  )

; This big-bang expression rotates the star:
(big-bang (star 75 "solid" "orange") ; “seed” aka “initial value” aka “initial state”
  ; A big-bang ‘on-tick’ clause is the word ‘on-tick’ grouped with a function to repeat
  ;  “on each tick” of the clock [up to 30 times per second].
  [on-tick counter]
  )
