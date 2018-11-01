;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname maze-generation) (compthink-settings #hash((prefix-types? . #f))))
; Maze Generation Section
; =======================

; in-grid?
; --------
; Do the check-expects there cover every way in which a point could be outside the grid?
;  If not, add more check-expects.

; neighbours
; ----------
; You should try all your functions with arguments different from just the one or ones in
;  the given check-expects (see the General Principles). Quite a few students found their
;  implementation of this function had errors, and caught that by trying a different argument.

; intersection
; ------------
; Warm up by making sure you can do this week's practice Part 1.

; random-element
; --------------
; Even though design check-expects of the usual form ...
#;(check-expect (random-element an-example-list) result-for-that-example)
;  ... have trouble expressing the randomness, you can still do design: just make those
;  check-expects be comments. For example, if we were designing a function to produce
;  a random even number less than a given even number, here are some design comments:
#;(check-expect (random-even-number 10) 0)
#;(check-expect (random-even-number 10) 2)
#;(check-expect (random-even-number 10) 4)
#;(check-expect (random-even-number 10) 6)
#;(check-expect (random-even-number 10) 8)
#;(check-expect (random-even-number 10) (* 2 0))
; ...
#;(check-expect (random-even-number 10) (* 2 4))
#;(check-expect (random-even-number 10) (* 2 (random 5)))
#;(check-expect (ranodm-even-number 10) (* 2 (random (/ 10 2))))

; random-neighbour
; ----------------
; A. See random-element for how to do design despite randomness.
; B. For any of the functions you are defining, you may call earlier functions you defined.

; bridge?
; -------
; A. Draw the point and the list of points.
; B. Read the comments beside the first check-expect.
; C. Very clearly express in words, i.e. describe for someone else, how to do this,
;     in particular, what would you tell someone to do with ...
#;(point 3 4)
#;(list (point 1 2)
        (point 3 3)
        (point 4 5)
        (point 2 4))
;  ... to produce:
#;(list (list 3 3) #;(list 3 5) (list 2 4) #;(list 4 4))

; maybe-attach
; ------------
; Explain the reason for each check-expect's result, in terms of the maze generation algorithm.
