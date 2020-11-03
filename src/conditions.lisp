(in-package :cl-user)
(defpackage cadence.conditions
  (:use :cl)
  (:import-from :cadence.notes
                :*maximum-octaves*)
  (:export :invalid-note
           :invalid-accidental
	   :too-much-octaves))
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
