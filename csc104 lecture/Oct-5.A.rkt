;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-5.A) (compthink-settings #hash((prefix-types? . #f))))
; In the previous lecture we had a motivation to examine and use the conjunction operation ‘and’
;  and its special behaviour. Let's now make a unary function ‘sorted?’ that takes a list of numbers
;  and determines whether the numbers are sorted in non-decreasing order: that will motivate the
;  introduction of some numeric comparison functions, and the use of the disjuction operation ‘or’.

; Some documentation and correctness:
(check-expect (sorted? (list 1 0 4)) #false)
(check-expect (sorted? (list 0 1 4)) #true)
(check-expect (sorted? (list 3 4 6 7 9 9 12)) #true) ; Non-decreasing, but not increasing.

; Numerical inequality functions
; ------------------------------
; The functions ‘<’, ‘<=’, ‘>’, and ‘>=’ take two or more numbers and check their ordering.
(check-expect (<  12 34) #true)
(check-expect (<  12  3) #false)
(check-expect (<   9  9) #false)
(check-expect (<= 12 34) #true)
(check-expect (<= 12  3) #false)
(check-expect (<=  9  9) #true)
; The functions ‘<=’ and ‘>=’ have the aliases ‘≤’ and ‘≥’, respectively.
(check-expect (≤ 12 45 66) #true)
; The following is an error, since these functions expect numbers, not a list:
#;(≤ (list 3 4 6 7 9 9 12))

; Now we can express some partial designs for ‘sorted?’:
(check-expect (sorted? (list 1 0 4)) (≤ 1 0 4))
(check-expect (sorted? (list 0 1 4)) (≤ 0 1 4))
(check-expect (sorted? (list 3 4 6 7 9 9 12)) (≤ 3 4 6 7 9 9 12))

; And here are two full designs:
(check-expect (sorted? (list 1 0 4))          (apply ≤ (list 1 0 4)))
(check-expect (sorted? (list 3 4 6 7 9 9 12)) (apply ≤ (list 3 4 6 7 9 9 12)))

; The following is commented out because we generalized it below.
#;(define (sorted? numbers)
    (apply ≤ numbers))

; Contracts
; ---------
; A function contract documents the datatype(s) of the argument(s) and the result.
; The contract for sorted? is : list → boolean
; The contract for ≤ is : number number ... → boolean

; Boundary/extreme/edge/special case(s)
; -------------------------------------
; It's reasonable, and in fact worthwhile, to allow asking whether a list with a single number
;  is sorted. It's also reasonable and worthwhile to consider all such lists to be sorted.
;  Since the inequality functions expect at least two numbers, the current design fails for
;  such lists.

(check-expect (sorted? (list 1234)) #true)

; What we want to ask:
;   Does the list have exactly one element,
;    or else
;   are the elements in non-decreasing order according to ‘≤’?

; We could use ‘same?’ to compare the length of the list with 1, but let's use ‘=’ which,
;  like the inequality functions, compares two or more numbers.
; The contract for = is : number number ... -> boolean

; The expected types for arguments and result of functions in our language tend to be either
;  exactly one of the six main types or any type. To express that any type of value is expected,
;  we use ‘any’. For example, the contract for ‘same?’ is: any any -> boolean

; Now we need to combine two expressions with ‘or’.
; The operation ‘or’ takes two or more expressions, evaluates them in order, determining if
;  AT LEAST one of the expressions produces #true.
 
; The truth table of ‘or’, for every combination of two booleans:
(check-expect (or #false #false) #false)
(check-expect (or #true  #false) #true)
(check-expect (or #false #true ) #true)
(check-expect (or #true  #true)  #true)
; That is “inclusive or”, which is sometimes written “and/or” in English.
; In other words, ‘or’ asks:        is the first  boolean true,
;                            and/or is the second boolean true,
;                            and/or is ....
; Sometimes, in English, ‘or’ is exclusive. For example:
;   “You can pick either option A or option B.”
; In that form people usually mean EXACTLY ONE of those options, not both.

; Like ‘and’, ‘or’ is special: it doesn't evaluate the remaining argument expressions if one of them
;  produces #true. For example:
(step (or (< 1 2) (/ 1 0)))

; Together, the following are now close to a full design, they just need to be combined with ‘or’:
(check-expect (sorted? (list 1234)) (= (length (list 1234)) 1))
(check-expect (sorted? (list 3 4 6 7 9 9 12)) (apply ≤ (list 3 4 6 7 9 9 12)))

(define (sorted? numbers)
  (or (= (length numbers) 1)
      (apply ≤ numbers)))

; As is often the case, we are relying on the special behaviour of ‘and’ and ‘or’, and choose
;  which expression to put first accordingly. The following demonstrates the problem if we
;  switch the order of the two ‘or’ed expressions:
(step (define (sorted? numbers)
        (or (apply ≤ numbers)
            (= (length numbers) 1)))
      (sorted? (list 1234)))
