(in-package :cl-user)
(defpackage trivial-constant-time/tests/main
  (:use :cl
        :trivial-constant-time
        :rove))
(in-package :trivial-constant-time/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :trivial-constant-time)' in your Lisp.

(deftest test-compare
  (testing "compare"
    (ok (= (compare '() '()) 1))
    (ok (= (compare '(#x11) '(#x11)) 1))
    (ok (= (compare '(#x12) '(#x11)) 0))
    (ok (= (compare '(#x11) '(#x11 #x12)) 0))
    (ok (= (compare '(#x11 #x12) '(#x11)) 0))))

(deftest test-byte-eq
  (testing "byte-eq"
    (ok (= (byte-eq 0 0) 1))
    (ok (= (byte-eq 0 1) 0))
    (ok (= (byte-eq 1 0) 0))
    (ok (= (byte-eq #xff #xff) 1))
    (ok (= (byte-eq #xff #xfe) 0))))

(deftest test-eq*
  (testing "eq*"
    (ok (= (eq* 1 1) 1))
    (ok (= (eq* 1 0) 0))))

;;; TODO

;; (deftest test-select
;;   (testing "copy"
;; 	   (ok ())))

;; (deftest test-copy
;;   (testing "copy"
;; 	   (ok ())))

;; (deftest test-less-or-eq
;;   (testing "less-or-eq"
;; 	   (ok ())))
