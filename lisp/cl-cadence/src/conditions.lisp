(in-package :cl-user)
(defpackage cadence.conditions
  (:use :cl)
  (:export :invalid-note
           :invalid-accidental
	   :too-much-octaves
	   :invalid-interval))
(in-package :cadence.conditions)

(define-condition invalid-note (error)
  ((note :initarg :note
	 :reader note))
  (:report (lambda (condition stream)
	     (format stream "~a is an invalid note.~&" (note condition)))))

(define-condition invalid-accidental (error)
  ((accidental :initarg :accidental
	       :reader accidental))
  (:report (lambda (condition stream)
	     (format stream "~a is an invalid accidental.~&" (accidental condition)))))

(define-condition too-much-octaves (error)
  ((maximum-octaves :initarg :maximum-octaves
		    :reader maximum-octaves))
  (:report (lambda (condition stream)
	     (format stream "Maximum octaves are set to ~a.~&" (maximum-octaves condition)))))

(define-condition invalid-interval (error)
  ((interval :initarg :interval
	     :reader interval))
  (:report (lambda (condition stream)
	     (format stream "~a is an invalid interval.~&" (interval condition)))))
