(defpackage sv/tests/main
  (:use :cl
        :sv
        :rove))
(in-package :sv/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :sv)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
