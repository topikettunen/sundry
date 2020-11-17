(defsystem "vokaabeli"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ("clack"
               "lack"
               "caveman2"
               "envy"
               "cl-ppcre"
               "uiop"
	       "dexador"
	       "jsown"
               "djula")
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view"))
                 (:file "web" :depends-on ("view" "words" "translate"))
                 (:file "view" :depends-on ("config"))
		 (:file "words" :depends-on ("conditions"))
		 (:file "translate" :depends-on ("conditions"))
		 (:file "conditions")
                 (:file "config"))))
  :description "Simple web application for generating writing exercises powered by Common Lisp"
  :in-order-to ((test-op (test-op "vokaabeli/tests"))))

(defsystem "vokaabeli/tests"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ("vokaabeli"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for sv"
  :perform (test-op (op c) (symbol-call :rove :run c)))
