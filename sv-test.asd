(defsystem "sv-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ("sv"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "sv"))))
  :description "Test system for sv"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
