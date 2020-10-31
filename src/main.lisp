(in-package :cl-user)
(defpackage serendipitous-vocable
  (:use :cl)
  (:export :start
	   :stop))
(in-package :serendipitous-vocable)

;;; User configurable acceptor would be nice.
(defparameter *sv-acceptor* (make-instance 'hunchentoot:easy-acceptor :port 8080))

;;; Eventually start using clack.
(defun start ()
  (hunchentoot:start *sv-acceptor*))

(defun stop ()
  (hunchentoot:stop *sv-acceptor*))
