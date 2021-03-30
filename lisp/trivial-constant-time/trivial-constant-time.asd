(defsystem "trivial-constant-time"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Best effor Common Lisp implementation in constant time utilities."
  :in-order-to ((test-op (test-op "trivial-constant-time/tests"))))

(defsystem "trivial-constant-time/tests"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ("trivial-constant-time"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for trivial-constant-time"
  :perform (test-op (op c) (symbol-call :rove :run c)))
