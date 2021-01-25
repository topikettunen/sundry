(defsystem "cl-wordnik"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on (:drakma
	       :cl-json)
  :components ((:file "wordnik"))
  :description "Common Lisp Wordnik API Client")
