(defpackage serendipitous-vocable/tests/main
  (:use :cl
        :serendipitous-vocable
        :rove))
(in-package :serendipitous-vocable/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :serendipitous-vocable)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
