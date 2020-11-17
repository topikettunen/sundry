(in-package :cl-user)
(defpackage vokaabeli.conditions
  (:use :cl)
  (:export :api-key-not-set))
(in-package :vokaabeli.conditions)

(define-condition api-key-not-set (error)
  ((api-key :initarg :api-key
	    :reader api-key)))
