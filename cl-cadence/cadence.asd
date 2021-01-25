(defsystem "cadence"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "scales" :depends-on ("notes" "conditions"))
		 (:file "intervals" :depends-on ("conditions" "utils"))
		 (:file "notes" :depends-on ("conditions"))
		 (:file "utils")
		 (:file "conditions"))))
  :description "Music Theory Toolkit"
  :in-order-to ((test-op (test-op "cadence/tests"))))

(defsystem "cadence/tests"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ("cadence"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cadence"
  :perform (test-op (op c) (symbol-call :rove :run c)))
