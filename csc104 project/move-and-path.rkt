;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname move-and-path) (compthink-settings #hash((prefix-types? . #f))))
; Moving Kat Section
; ==================
; This is meant to be a bit more of a challenge. In particular it's a good time to consider the
;  problem solving technique mentioned in Part C below.

; A. For each check-expect: draw the arguments, and the result, in a 4 × 4 grid.
; B. For each check-expect: explain why the arguments should produce the result.

; C. Recall how we designed ‘comma-separate’ in lecture: we first solved part of the problem,
;     and then made it more general. That is another general principle: consider solving a
;     simplified version of the problem first. In particular, if a problem has been broken down
;     into separate cases, try solving each one separately, or at least just start with a single
;     case. For move: implement enough of it so that it is correct for arguments that should
;     be handled “like” the arguments in the first check-expect.

; D. There is a lot of similar, but not quite the same, computation here. So ‘local’ can make
;     it a lot nicer (“tidier” as one student described it). That is also less error-prone:
;     the less repetitive typing or copy-and-modifying, the less chance for typos (as at least
;     one student discovered when we hunted for the problem in a sea of ‘X’s, ‘point’s, ‘-1’s
;     etc).

; Path Finding Section
; ====================
; This is meant to be challenging, and definitely requires applying problem solving techniques.
; Do Parts A and B below, then the rest in the order D-C-E-F or C-E-D-F.

; A. For each check-expect: draw the arguments.
; B. For the first two check-expects: draw the result, and explain why it's correct.

; C. Decide what the result values should be for the third and fourth check-expects, i.e.
;     draw the path, if there is one, between the start and end point.

; D. Implement enough of path to handle cases “like” the first two check-expects.

; E. For the third and fourth check-expects, decide what the values of each of the following
;     should be, manually: write down the corresponding (path _ _ _) expression from the
;     body of the local function, draw that path yourself, then replace result with that.

#;(rest-of-path (point  0 0))
(check-expect (path _ _ _) result)
#;(rest-of-path (point  0 2))
(check-expect (path _ _ _) result)
#;(rest-of-path (point -1 1))
(check-expect (path _ _ _) result)
#;(rest-of-path (point  1 1))
(check-expect (path _ _ _) result)

; F. Explain how to combine those four results to get the expected results (from part C).
