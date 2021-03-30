(in-package :cl-user)
(defpackage cadence.scales
  (:use :cl
        :cadence.conditions
	:cadence.notes))
(in-package :cadence.scales)

;;; Scale CLOS representation

(defclass scale ()
  ((key :initarg :key
	:accessor key
	:type character)
   (intervals :initarg :intervals
	      :accessor intervals
	      :type array)))

;;; 12-tone chromatic scale

(defun make-12tone-chromatic-scale (&key key))
