(in-package :cl-user)

(defpackage licenser-asd
  (:use :cl :asdf))

(in-package :licenser-asd)

(defsystem "licenser"
  :version "0.1.0"
  :author "Topi Kettunen"
  :license "MIT"
  :depends-on (:cffi
	       :cffi-grovel
	       :cffi-toolchain
	       :cl-json
               :drakma
               :unix-opts
               :cl-ppcre)
  :components ((:file "licenser"))
  :description "CLI for choosing license"
  :build-operation :static-program-op
  :build-pathname "licenser"
  :entry-point "licenser:main")
