(defsystem "sv"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on ("clack"
               "lack"
               "caveman2"
               "envy"
               "cl-ppcre"
               "uiop"
	       "datafly"
	       "dexador"
	       "jsown"

               ;; for @route annotation
               "cl-syntax-annot"

               ;; HTML Template
               "djula")
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view"))
                 (:file "web" :depends-on ("view" "words"))
                 (:file "view" :depends-on ("config"))
                 (:file "config")
		 (:file "words"))))
  :description "Simple web application for generating writing exercises powered by Common Lisp"
  :in-order-to ((test-op (test-op "sv-test"))))
