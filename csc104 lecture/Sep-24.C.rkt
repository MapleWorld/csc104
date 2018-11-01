;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "2018-fall-reader.rkt" "csc104")((modname Sep-24.C) (compthink-settings #hash((prefix-types? . #false))))
; Let's make a function to add up 1 + 2 + 3 + ... + n.

; First, let's use the binary function ‘same?’, which asks whether two values are the same, to see if
;  the two expressions from today's part B produce the same value:
(same? (+ (+ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
          (+ 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
       (* 16 15))
; That produces #true.

; Next week we will see how to make a choice based on the result of a question, but what we really
;  want here is to *claim* that those two expressions produce the same value. The check-expect
;  operation let's us express, and have the computer check, such an expectation:
(check-expect (+ (+ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
                 (+ 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
              (* 16 15))
; When you run this file DrRacket reports the results of all check-expect expressions, which are
;  also just called “test”s.

; Uncomment the following expression and run the file, to see a report about a “failing” test case.
#;(check-expect (* 2 51) 104)

; A major component of professional software development is “Test-Driven Development” (TDD).
;  Let's make some tests to document, check, and design, a function to add up 1 + 2 + ... + n.

; What we would like the function to accomplish, for 15:
(check-expect (add-up-1-to 15)
              (+ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

; Normally we could not use a definition before the definition, but to support TDD the language
;  delays all check-expects until the rest of the file has run.

; So, unlike the following, which is outside a check-expect, the above check-expect can use
;  add-up-1-to even though the definition of add-up-1-to occurs later in this file.
#;(add-up-1-to 15)

; We use tests/checks for three reasons:
;   1. Document for us and other readers, the intended behaviour of a function.
;   2. Test that a function works.
;   3. Document our design process.
; Some checks might be for one, two, or even all of three of those reasons.

; The previous check-expect documents and tests, and the one before that is a test of our reasoning
;  and helps design the function. The following is some more explicit design:
(check-expect (add-up-1-to 15) (/ (* 16 15)
                                  2))
; Thinking through the reasoning again, but for 1 + 2 + ... + 100, we get:
(check-expect (add-up-1-to 100) (/ (* 101 100)
                                   2))

; Here's a simple one that we can just calculate, and is essentially just for testing:
(check-expect (add-up-1-to 2) 3)

; But we can also take the approach used for 15 and 100:
(check-expect (add-up-1-to 2) (/ (* 3 2)
                                 2))

; Working out concrete examples to understand a general situation is a common and powerful approach,
;  not just for programming but for most understanding and problem solving. Many aspects of problem
;  solving are required, and made clearer, by solving computing problems.

; To generalize from the above examples we make:
;   • any uses of the argument explicit
;   • identify any coincidental uses of the argument

; The ‘15’ in the formula here is because there are 15 rows to add up, and the ‘16’ is one more than
;  15 because we start adding the first number, which is 1, and the last, which is the argument 15.
(check-expect (add-up-1-to 15) (/ (* (+ 1 15) 15)
                                  2))
; That's the same for 100:
(check-expect (add-up-1-to 100) (/ (* (+ 1 100) 100)
                                   2))
; And also for 2:
(check-expect (add-up-1-to 2) (/ (* (+ 1 2) 2)
                                 2))
; But notice that the third ‘2’ is only coincidentally the same as the argument.

; We now have three examples that illustrate the general case, and any one of them (as long as we're
;  careful about the third ‘2’ in the third example) can be easily turned into a definition by:
;   1. Changing ‘check-expect’ to ‘define’.
;   2. Replacing the argument, and any non-coincidental occurrences of it, with a parameter name.

(define (add-up-1-to n)
  (/ (* (+ 1 n) n)
     2))

; A check-expect that is ready to be turned into a definition that way is called a “full design”
;  check-expect.

; If you run this file the tests should all pass. That isn't too surprising, since most of them match,
;  or are simililar to, the body of the function. But the first test for the function does check the
;  correctness, for 15.

; Here's a “boundary” [aka “edge” or “extreme” or “special”] case test:
(check-expect (add-up-1-to 1) 1)

; Checking a “generic” [unspecial] number such as 15, and any numbers that seem special,
;  such as 1, helps increase our confidence that the function works in general.
(check-expect (add-up-1-to 1) 1)

; That might seem too special, so let's also include the simplest non-special case:
(check-expect (add-up-1-to 2) 3) ; Testing correctness against my arithmetic.
(check-expect (add-up-1-to 2) (+ 1 2)) ; Testing, and documentation of intent.

; One could argue that being the simplest non-special case makes 2 special, see:
#;(url->browser "https://en.wikipedia.org/wiki/Interesting_number_paradox")
