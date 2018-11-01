;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-19.C) (compthink-settings #hash((prefix-types? . #f))))
; Let's now make a predicate that will let us select certain elements of the database.

(define database (list (list "Ada Lovelace"  1815)
                       (list "Kurt Goedel"   1906)
                       (list "Alonzo Church" 1903)
                       (list "Alan Turing"   1912)
                       (list "Grace Hopper"  1906)
                       (list "Miriam Mann"   1907)))

(define name first)
(define birth-year second)

; We'll make a unary predicate that determines whether a record represents someone born after 1905.
; born-after-1905? : list → boolean

(check-expect (born-after-1905? (list "Ada Lovelace"  1815)) #false)
(check-expect (born-after-1905? (list "Kurt Goedel"   1906)) #true)

; Partial Design:
(check-expect (born-after-1905? (list "Ada Lovelace"  1815)) (> 1815 1905))
(check-expect (born-after-1905? (list "Kurt Goedel"   1906)) (> 1906 1905))

; Full Design:
(check-expect (born-after-1905? (list "Ada Lovelace" 1815))
              (> (birth-year (list "Ada Lovelace" 1815)) 1905))
(check-expect (born-after-1905? (list "Kurt Goedel" 1906))
              (> (birth-year (list "Kurt Goedel" 1906)) 1905))

(define (born-after-1905? a-record)
  (> (birth-year a-record) 1905))

; Watch it used on a single entry from the database:
(step (born-after-1905? (list "Grace Hopper" 1906)))

; Both mapping and sifting use it on each entry:
(step (map born-after-1905? database))

; That result tells us that sifting will produce the second, fourth, fifth, and sixth entries:
(check-expect (sift born-after-1905? database) (list (list "Kurt Goedel" 1906)
                                                     (list "Alan Turing" 1912)
                                                     (list "Grace Hopper" 1906)
                                                     (list "Miriam Mann" 1907)))

; We can process that subset of the database just as we would the whole database, for example:
(apply text-join (map name database))
