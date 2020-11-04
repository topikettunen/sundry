(in-package :cl-user)
(defpackage cadence.intervals
  (:use :cl
        :cadence.conditions)
  (:import-from :cadence.utils
		:substringp))
(in-package :cadence.intervals)

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

(defvar *intervals*
  '((+unison+ +diminished-second+)
    (+minor-second+ +augmented-unison+)
    (+major-second+ +diminished-third+)
    (+minor-third+ +augmented-second+)
    (+perfect-fourth+ +augmented-third+)
    (+augmented-fourth+ +diminished-fifth+)
    (+perfect-fifth+ +diminished-sixth+)
    (+minor-sixth+ +augmented-fifth+)
    (+major-sixth+ +diminished-seventh+)
    (+minor-seventh+ +augmented-sixth+)
    (+major-seventh+ +diminished-octave+)
    (+octave+ +augmented-seventh+)))

;;; Interval CLOS representation

(defclass interval ()
  ((name :initarg :name
	 :accessor name
	 :type string)
   (number-of-semitones :initarg :number-of-semitones
			:accessor number-of-semitones
			:type integer)))

(defun normalize-interval-name (interval)
  "Since interval symbols are constants they are surrounded with plus signs. So
this just removes them so they are more meaningful when used as a name for
CLOS object."
  (remove #\+ (symbol-name interval)))

(defun correct-interval-p (name)
  (let ((upcased-name (string-upcase name)))
    (loop named outer
	  for interval-pair in *intervals*
	  do (loop for pair in interval-pair
		   do (let ((normalized-name (normalize-interval-name pair)))
			(when (substringp upcased-name normalized-name)
			  (return-from outer t)))))))

(defun make-interval (name)
  (if (correct-interval-p name)
      (let ((number-of-semitones (symbol-value (read-from-string (format nil"+~a+" name)))))
	(make-instance 'interval
		       :name name
		       :number-of-semitones number-of-semitones))
      (error 'invalid-interval :interval name)))
