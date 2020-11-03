(in-package :cl-user)
(defpackage cadence.notes
  (:use :cl
	:cadence.conditions)
  (:export :*maximum-octaves*))
(in-package :cadence.notes)

;;; Intervals

(defconstant +unison+ 0)
(defconstant +diminished-second+ 0)

(defconstant +minor-second+ 1)
(defconstant +augmented-unison+ 1)

(defconstant +major-second+ 2)
(defconstant +diminished-third+ 2)

(defconstant +minor-third+ 3)
(defconstant +augmented-second+ 3)

(defconstant +diminished-fourth+ 4)
(defconstant +major-third+ 4)

(defconstant +perfect-fourth+ 5)
(defconstant +augmented-third+ 5)

(defconstant +augmented-fourth+ 6)
(defconstant +diminished-fifth+ 6)

(defconstant +perfect-fifth+ 7)
(defconstant +diminished-sixth+ 7)

(defconstant +minor-sixth+ 8)
(defconstant +augmented-fifth+ 8)

(defconstant +major-sixth+ 9)
(defconstant +diminished-seventh+ 9)

(defconstant +minor-seventh+ 10)
(defconstant +augmented-sixth+ 10)

(defconstant +major-seventh+ 11)
(defconstant +diminished-octave+ 11)

(defconstant +octave+ 12)
(defconstant +augmented-seventh+ 12)

;;; Note names

(defconstant +note-names+
  '(#\C nil #\D nil #\E #\F nil #\G nil #\A nil #\B))

;;; Accidentals

(defconstant +accidentals+
  '(:double-flat :flat :natural :sharp :douple-sharp))

;;; Octaves

(defparameter *maximum-octaves* 9)
(defparameter *octaves*
  (loop for octave from 0 to *maximum-octaves*
	collect octave))

;;; Note CLOS representation

(defclass note ()
  ((name :initarg :name
	 :initform #\C
	 :accessor name
	 :type character)
   (accidental :initarg :accidental
	       :initform :natural
	       :accessor accidental
	       :type symbol)
   (octave :initarg :octave
	   :initform 4
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
