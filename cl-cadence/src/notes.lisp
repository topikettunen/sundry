(in-package :cl-user)
(defpackage cadence.notes
  (:use :cl
	:cadence.conditions)
  (:export :*maximum-octaves*
	   :make-note))
(in-package :cadence.notes)

;;; Note names

(defvar +note-names+
  '(#\C nil #\D nil #\E #\F nil #\G nil #\A nil #\B))

;;; Accidentals

(defvar +accidentals+
  '(:double-flat :flat :natural :sharp :douple-sharp))

;;; Octaves

(defparameter *maximum-octaves* 9)
(defparameter *octaves*
  (loop for octave from 0 to *maximum-octaves*
	collect octave))

;;; Note CLOS representation

(defclass note ()
  ((name :initarg :name
	 :accessor name
	 :type character)
   (accidental :initarg :accidental
	       :accessor accidental
	       :type symbol)
   (octave :initarg :octave
	   :accessor octave
	   :type integer)))

(defun make-note (&optional (name #\C) (accidental :natural) (octave 4))
  (cond ((or (not name) (not (member name +note-names+)))
	 (error 'invalid-note :note name))
	((not (member accidental +accidentals+))
	 (error 'invalid-accidental :accidental accidental))
	((> octave *maximum-octaves*)
	 (error 'too-much-octaves :maximum-octaves *maximum-octaves*))
	(t (make-instance 'note :name name :accidental accidental :octave octave))))
