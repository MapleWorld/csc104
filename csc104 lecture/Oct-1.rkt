;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Oct-1) (compthink-settings #hash((prefix-types? . #f))))
; Booleans Revisited
; ==================

; Recall
; ------
; There are two boolean values, which we write literally as:
#true
#false
; Those two values are the only two values of type boolean.
; Boolean values are a good choice for yes/no true/false questions, i.e. results of functions
;  representing questions, and yes/no true/false choices, in which case we use them as arguments.


; Connections [OPTIONAL]
; ----------------------
; Many students have been asking about connections with other programming languages, so I'll include
;  some commentary about that occasionally, but will not test you on it. YOU MAY SKIP THIS SECTION
;  OF THE FILE, AND CONTINUE BELOW WHERE IT SAYS “BACK TO OUR LANGUAGE!”.
;
; Early in computing, common programming languages had very few datatypes, typically just “small”
;  integers, and “fixed precision” numeric approximations. Zero was often used to represent false,
;  and any non-zero number meant true. Nowadays there are many variants of that approach. For example,
;  Python has a boolean datatype, but also interprets non-booleans as sort-of-like booleans. Whether
;  a value behaves “like” true or false depends on context as well (‘>>>’ here is a Python prompt):
; >>> True == 1
; True
; >>> True is 1
; False
; >>> 1 is 1
; True
; >>> not 1
; False
; >>> not 0
; True
; >>> not ()
; True
; >>> not False
; True
; >>> not [False]
; False
; >>> not (False)
; True
; >>> not ""
; True
; >>> not " "
; False
;
; Unfortunately, languages that blur distinctions between datatypes each tend to have their
;  own unique set of rules, even if we just look at the rules for how non-booleans can be
;  treated as booleans. This is one of the reasons that teaching languages avoid such blurring:
;  no set of rules is particularly universal, nor even particularly useful compared with the
;  power of the core universal programming language features. The core features are more than
;  enough to keep us occupied and doing interesting things fairly easily, for an entire term.

; There's a famous amusing talk having fun with some of Ruby's and Javascript's rules:
#;(url→browser "https://www.destroyallsoftware.com/talks/wat")

; A group recently studied how programmers thought a new language would behave (there was no new
;  language, they were just told that to get the best responses about what they expect is most
;  natural for a modern non-theoretical programming language). For booleans, see section 6 of:
#;(url→browser
   "https://cs.brown.edu/~sk/Publications/Papers/Published/tpk-crowdsource-lang-design/paper.pdf")
; There was little consistency and consensus. One of the authors, Shriram Krishnamurthi, contributed
;  to the development of the Racket teaching languages, which our language is a variant of. I'm sure
;  he wasn't surprised by the results: someone making a teaching language has noticed non-teaching
;  languages have too many arbitrary rules, with no clear “natural” set beyond a small number of them.


; BACK TO OUR LANGUAGE!
; ---------------------
; Let's make a new unary function named ‘exclamation?’, that determines whether a text ends with an
;  exclamation mark. It will produce a boolean, and during the design of it we will see a reason to
;  use a new boolean operation with a special behaviour.

; Some tests that document (i.e. illustrate) our goal, and that will also help check correctness:
(check-expect (exclamation? "hey!") #true)
(check-expect (exclamation? "hey?") #false)
(check-expect (exclamation? "hello friends") #false)
; This one was put in near the end of the design, which is why most of the discussion doesn't
;  mention it:
(check-expect (exclamation? "hello friends!") #true)

; The results for those three arguments were deteremined by me/us looking at the argument.
; Now we start generalizing, making more and more of what we do explicit as a computation for
;  the computer to do.

; After we look at the last character we compare it with "!":
(check-expect (exclamation? "hey?") (same? "?" "!"))
(check-expect (exclamation? "hello friends") (same? "s" "!"))
(check-expect (exclamation? "hey!") (same? "!" "!"))

; The binary function ‘character’ takes a text t and a natural number i, and produces a text
;  containing just the single character in t at the “index” i.

; The natural numbers are: 0, 1, 2, 3, 4, 5, ....
; In CS and some mathematics, zero gets included the natural numbers, but in the rest of mathematics
;  zero is not included. So we follow the convention that includes zero.

; Indexing in CS usually starts from 0, for example:
;
;        "hello friends"
; index:  0123456789...

(check-expect (character "hello friends"  0)  "h")
(check-expect (character "hello friends"  1)  "e")
(check-expect (character "hello friends"  5)  " ")

; During lecture we asked for the length of that text, recorded here:
(check-expect (text-length "hello friends") 13)
; So we deduced that the last character has the index 12, which is one less than 13:
(check-expect (character "hello friends" 12)  "s")

; Let's use that function to extract the last character in each example:
(check-expect (exclamation? "hello friends") (same? (character "hello friends" 12)
                                                    "!"))
(check-expect (exclamation? "hey!") (same? (character "hey!" 3)
                                           "!"))
(check-expect (exclamation? "hey?") (same? (character "hey?" 3)
                                           "!"))

; Explicit about the “one less than”:
(check-expect (exclamation? "hello friends") (same? (character "hello friends"
                                                               (- 13 1))
                                                    "!"))
(check-expect (exclamation? "hey!") (same? (character "hey!"
                                                      (- 4 1))
                                           "!"))
(check-expect (exclamation? "hey?") (same? (character "hey?"
                                                      (- 4 1))
                                           "!"))

; Explicit about using ‘text-length’:
(check-expect (exclamation? "hello friends") (same? (character "hello friends"
                                                               (- (text-length "hello friends") 1))
                                                    "!"))
(check-expect (exclamation? "hey!") (same? (character "hey!"
                                                      (- (text-length "hey!") 1))
                                           "!"))
(check-expect (exclamation? "hey?") (same? (character "hey?"
                                                      (- (text-length "hey?") 1))
                                           "!"))

; Those three formulas are the same, except where (and only where) they use the argument literally.
; So that can be generalized, by copying one of those check-expects, changing ‘check-expect’ to
;  ‘define’, and changing the literal argument to a parameter name.

#;(define (exclamation? a-text)
    (same? (character a-text (- (text-length a-text) 1))
           "!"))
; That is commented out, because we noticed it doesn't work for the empty text:
(step (define (exclamation? a-text)
        (same? (character a-text (- (text-length a-text) 1))
               "!"))
      (exclamation? ""))

(check-expect (exclamation? "") #false) ; We certainly agree it shouldn't produce #true.

; One way of phrasing the question:
;   Is the text not empty,
;   and,
;   is the last character an exclamation mark?

; Let's look at how we express the ‘not’ and the ‘and’ aspect of that question in our language.

; An important development in the study of logic was the interpretation of questions and statements
;  as being true or false, and logical connectives as combining booleans as opposed to combining
;  phrases. For example, boolean logic treats ‘not’ as a function receiving a boolean, not a word
;  that modifies a phrase. Our CSC104 language includes that unary function:
(check-expect (not #false) #true)
(check-expect (not #true) #false)

; As with any function, ‘not’ does not change the argument expression, it only ever sees the boolean
;  value of the argument expression. However, the flipping behaviour leads to the natural result if
;  we read an expression with a question for the argument:
(step (not (number? "cat")))
(check-expect (not (number? "cat")) #true)  ; "cat" is not a number? True.
(check-expect (not (text?   "cat")) #false) ; "cat" is not a text? False.
(check-expect (not (same? "cat" "dog")) #true)  ; "cat" is not the same as "dog"? True.
(check-expect (not (same? "cat" "cat")) #false) ; "cat" is not the same as "cat"? False.

; We can use that function to expression the “text not empty” part of our question:
(check-expect (not (same? "cat" "")) #true)
(check-expect (not (same? ""    "")) #false)

; There is also a binary function in our language for “not the same”:
(check-expect (differ? "cat" "dog") #true) ; do “cat” and “dog” differ?
(check-expect (differ? "cat" "cat") #false) ; do “cat” and “cat” differ?
; We could also use it to say “different from the empty text”:
(check-expect (differ? "cat" "") #true)
(check-expect (differ? ""    "") #false)

; For ‘and’, notice something special about the way we humans often use it: the second part of
;  our question above only fully makes sense if the first part is true. We often rely on that
;  when using ‘and’ amongst ourselves. Pay attention to it in everyday usage and try to spot
;  when that is being relied upon.

; Most programming languages, including ours, implement ‘and’ specially, which is why I haven't
;  been calling it a function: most programming languages reserve the term “function” for
;  operations that depend only on the argument values, and don't control how the argument values
;  are computed from the argument expressions. But first, let's just see what ‘and’ produces
;  when given every possible combination of two boolean values (this is called a “Truth Table”):
(check-expect (and #true   #true)  #true)
(check-expect (and #true  #false) #false)
(check-expect (and #false  #true) #false)
(check-expect (and #false #false) #false)

; In general: for two or more boolean values, ‘and’ determines whether they are all true.

; Now let's see the non-function-like behaviour:
(define x 0)
(step (and (differ? x 0) (same? (/ 1 x) 5)))
; Even with the parallel stepping option on, that did not step the two argument expressions at
;  the same time. The operation ‘and’ takes control, asks for the value of the first argument
;  expression, and if that's false it doesn't bother with the rest since they clearly won't
;  all produce true. If ‘and’ were a function, both argument expressions would be evaluated,
;  and the second one produces an error because it divides 1 by 0. Let's try ‘list’ instead,
;  which is a very “mild” function: it merely receives and holds on to the arguments:
(step (list (differ? x 0) (same? (/ 1 x) 5))) ; We get an error.

; In general: ‘and’ proceeds left to right, stopping early if an argument expression produces
;  false. This behaviour is often referred to as “short-circuiting”, as in “taking a shortcut”.
;  Watch these steps:
(step (and (same? (+ 1 1) 3) (same? (+ 1 1) 3))
      (and (same? (+ 1 1) 3) (same? (+ 1 1) 2))
      (and (same? (+ 1 1) 2) (same? (+ 1 1) 3))
      (and (same? (+ 1 1) 2) (same? (+ 1 1) 2)))

; Let's use it!
(define (exclamation? a-text)
  ; Not the empty text, and the last character is "!".
  (and (differ? a-text "")
       (same? (character a-text
                         (- (text-length a-text) 1))
              "!")))

; Notice the short-circuiting behaviour in the first of these:
(step (exclamation? "")
      (exclamation? "cat")
      (exclamation? "dog!"))

; If we swap the order of the two expressions being ‘and’ed (aka “conjoined”), we get a problem
;  for the empty text, although it's fine for other text arguments:
(step (define (exclamation? a-text)
        ; The last character is "!", and a-text is not empty.
        (and (same? (character a-text
                               (- (text-length a-text) 1))
                    "!")
             (differ? a-text "")))
      (exclamation? "")
      (exclamation? "cat"))
