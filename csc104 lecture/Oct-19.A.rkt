;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-19.A) (compthink-settings #hash((prefix-types? . #f))))
; Lists of Lists
; ==============

; List elements can be lists.
; The following defines ‘database’ to be a list with six elements,
;  each element is a list with two elements.
(define database (list (list "Ada Lovelace"  1815)
                       (list "Kurt Goedel"   1906)
                       (list "Alonzo Church" 1903)
                       (list "Alan Turing"   1912)
                       (list "Grace Hopper"  1906)
                       (list "Miriam Mann"   1907)))

(check-expect (length database) 6) ; The list has six elements.

; Each element is a list:
(check-expect (map list? database) (list #true #true #true #true #true #true))

; We can get a list of the lengths of the elements:
(check-expect (map length database) (list (length (list "Ada Lovelace"  1815))
                                          (length (list "Kurt Goedel"   1906))
                                          (length (list "Alonzo Church" 1903))
                                          (length (list "Alan Turing"   1912))
                                          (length (list "Grace Hopper"  1906))
                                          (length (list "Miriam Mann"   1907))))
(check-expect (map length database) (list 2 2 2 2 2 2)) ; Each element is a list with two elements.
; In particular, each element has the same length:
(check-expect (apply = (map length database)) #true)

; Some individual elements of the database:
(check-expect (first database)  (list "Ada Lovelace"  1815))
(check-expect (second database) (list "Kurt Goedel"   1906))
(check-expect (third database)  (list "Alonzo Church" 1903))

; The first element of the second element:
(check-expect (first (second database)) "Kurt Goedel")

; Let's get the first element of each element:
(check-expect (map first database) (list "Ada Lovelace"
                                         "Kurt Goedel"
                                         "Alonzo Church"
                                         "Alan Turing"
                                         "Grace Hopper"
                                         "Miriam Mann"))
; Let's get the second element of each element:
(check-expect (map second database) (list 1815 1906 1903 1912 1906 1907))

; In particular, the first element of each element is a text:
(check-expect (map text? (map first database)) (list #true #true #true #true #true #true))
; And the second element of each element is a number:
(check-expect (map number? (map second database)) (list #true #true #true #true #true #true))

; Each element of the list has the same “structure”: a list with two elements, the first
;  being a text and the second being a number. In “relational” databasing, a list of lists
;  all with the same structure is called a “table”, and each element is called a “record”
;  (aka a “row”). Because each element has the same structure, we can process the elements
;  uniformly, in particular via map.

; Once we get some information from each record, we often combine the results with apply.
; For example, we could call the function ‘comma-separate’ that we made to present all
;  the names from the database. The part of comma-separate that did most of the work was
;  the apply of text-join.
(check-expect (apply text-join (map first database))
              ; Not as nice as comma-separate, but illustrates the principle:
              "Ada LovelaceKurt GoedelAlonzo ChurchAlan TuringGrace HopperMiriam Mann")

; General list functions in our language such as length, first, and reverse do not change
;  their behaviour based on the types of the elements.
(check-expect (reverse database)
              ; The elements aren't altered, they just occur in a different order:
              (list (list "Miriam Mann" 1907)
                    (list "Grace Hopper" 1906)
                    (list "Alan Turing" 1912)
                    (list "Alonzo Church" 1903)
                    (list "Kurt Goedel" 1906)
                    (list "Ada Lovelace" 1815)))

; We could affect the elements themselves by mapping instead:
(check-expect (map reverse database) (list (list 1815 "Ada Lovelace")
                                           (list 1906 "Kurt Goedel")
                                           (list 1903 "Alonzo Church")
                                           (list 1912 "Alan Turing")
                                           (list 1906 "Grace Hopper")
                                           (list 1907 "Miriam Mann")))

; “Representation Independence”
; -----------------------------
; Each record in our database represents an early Computer Scientist, with their name
;  and year of birth. I decided to make the name the first element and the year the
;  second element, but could have decided to record the year first and then the name.
;  This is an arbitrary decision about how to “represent” the information. It's a good
;  idea to hide the details of such arbitrary decisions to make our code as
;  “representation independent” as possible.

; So let's make variables to refer to the functions that get a name and a birth year
;  from a record:
(define name first) ; name is now an alias for first
(define birth-year second) ; birth-year is now an alias for second

; Now, for example, the expression that gets all the names can be written a bit more clearly:
(map name database)

; We designed step so that it doesn't show the substitution of variables that refer
;  to functions, specifically because we usually make such variables in order to
;  name and “black box” their behaviour. Notice in the following that ‘database’ gets
;  replaced but not ‘birth-year’, and when birth-year finally gets called it just behaves
;  like second would:
(step (map birth-year database))
