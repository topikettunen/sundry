(in-package :cl-user)
(defpackage cadence/tests/main
  (:use :cl
        :cadence
        :rove))
(in-package :cadence/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cadence)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
