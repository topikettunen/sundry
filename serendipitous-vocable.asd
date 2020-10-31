(defsystem "serendipitous-vocable"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on (:dexador
	       :jsown
	       :hunchentoot		; woo could be used here eventually
	       :cl-who
	       :cl-fad)
  :components ((:module "src"
		:components
		((:file "main")
		 (:file "handlers" :depends-on ("words"))
		 (:file "words"))))
  :description "Simple tool for generating writing exercises"
  :in-order-to ((test-op (test-op "serendipitous-vocable/tests"))))

(defsystem "serendipitous-vocable/tests"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on (:serendipitous-vocable
	       :rove)
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for serendipitous-vocable"
  :perform (test-op (op c) (symbol-call :rove :run c)))
