;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-22.B) (compthink-settings #hash((prefix-types? . #f))))
; Functions Defining Functions
; ============================

; The two expressions from the first part of this lecture differ only by a number:

(local [(define lower-bound 50)
        (define (above-bound? x)
          (> x lower-bound))]
  (sift above-bound? (list 123 45 67 890)))

(local [(define lower-bound 500)
        (define (above-bound? x)
          (> x lower-bound))]
  (sift above-bound? (list 123 45 67 890)))

; That can be captured as a function we'll define:
; aboves : number → list
; For a number, produce a list of the elements in (list 123 45 67 890)) that are above that number.

(check-expect (aboves 50) (list 123 67 890))
(check-expect (aboves 500) (list 890))

; Full Design:
(check-expect (aboves 50) (local [(define lower-bound 50)
                                  (define (above-bound? x)
                                    (> x lower-bound))]
                            (sift above-bound? (list 123 45 67 890))))

(check-expect (aboves 500) (local [(define lower-bound 500)
                                   (define (above-bound? x)
                                     (> x lower-bound))]
                             (sift above-bound? (list 123 45 67 890))))

#;(define (aboves a-lower-bound)
    (local [(define lower-bound a-lower-bound)
            (define (above-bound? x)
              (> x lower-bound))]
      (sift above-bound? (list 123 45 67 890))))

; That can be simplified: there's no need to name the argument again via ‘lower-bound’,
;  we can just refer to the argument directly:
(define (aboves a-lower-bound)
  (local [(define (above-bound? x)
            (> x a-lower-bound))]
    (sift above-bound? (list 123 45 67 890))))

; Notice how argument substitution very explicitly make a specific version of ‘above-bound?’:
(step (aboves 50))

; Each time ‘aboves’ is called, it essentially makes a unary version of the function ‘>’, by
;  “making constant” (aka “fixing”) the second argument of ‘>’ in the body of ‘above-dbound?’.
;  This is called “specializing” the function ‘>’.

(check-expect (aboves 75) (list 123 890))
(check-expect (aboves 25) (list 123 45 67 890))
(check-expect (aboves 1000) (list))


; Let's make a function constant-list : number any → list.
; Given a number and any value, it will make a list of that number of copies of the value.
(check-expect (constant-list 5 "blueberry")
              (list "blueberry" "blueberry" "blueberry" "blueberry" "blueberry"))

; The approach we'll take is to make that list is to make a list with five elements,
;  and then use map to change each element to "blueberry".

; Partial Design:
(check-expect (constant-list 5 "blueberry")
              (local [(define (blueberry whatever)
                        "blueberry")]
                (list (blueberry 0) (blueberry 1) (blueberry 2) (blueberry 3) (blueberry 4))))

; Fuller Design:
(check-expect (constant-list 5 "blueberry")
              (local [(define (blueberry whatever)
                        "blueberry")]
                (map blueberry (list 0 1 2 3 4))))

; Full Design (except the local function's name is misleadingly specific):
(check-expect (constant-list 5 "blueberry")
              (local [(define (blueberry whatever)
                        "blueberry")]
                (map blueberry (range 0 5 1))))

(define (constant-list a-length an-element)
  (local [(define (make-element whatever)
            an-element)]
    (map make-element (range 0 a-length 1))))

(step (constant-list 5 "cherry"))

(apply text-join (constant-list 100 "avocado"))


; Now, finally, we can generalize the sifting of our database.

(define database (list (list "Ada Lovelace"  1815)
                       (list "Kurt Goedel"   1906)
                       (list "Alonzo Church" 1903)
                       (list "Alan Turing"   1912)
                       (list "Grace Hopper"  1906)
                       (list "Miriam Mann"   1907)))
(define name first)
(define birth-year second)

; Let's make a function born-afters : number → list .
; Produce the list of the records in the database for people born after a particular year.

(check-expect (born-afters 1905)
              (local [(define (born-after? a-record)
                        (> (birth-year a-record) 1905))]
                (sift born-after? database)))

(check-expect (born-afters 1900)
              (local [(define (born-after? a-record)
                        (> (birth-year a-record) 1900))]
                (sift born-after? database)))

(define (born-afters a-year)
  (local [(define (born-after? a-record)
            (> (birth-year a-record) a-year))]
    (sift born-after? database)))

; We can now “query” the database for all people born after a particular year:

(step (born-afters 1950))

(born-afters 1910)

(map name (born-afters 1906))
