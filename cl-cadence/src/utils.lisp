(in-package :cl-user)
(defpackage cadence.utils
  (:use :cl)
  (:export :substringp))
(in-package :cadence.utils)

(defun substringp (a b &key (test 'char=))
  (search (string a)
	  (string b)
	  :test test))
