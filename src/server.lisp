(in-package :serendipitous-vocable)

(defparameter *sv-acceptor* (make-instance 'hunchentoot:easy-acceptor :port 8080))

(setq cl-who:*attribute-quote-char* #\")

(defmacro standard-page ((&key title) &body body)
  `(cl-who:with-html-output-to-string (*standard-output* nil :prologue t :indent t)
     (write-string "<!DOCTYPE html>" *standard-output*)
     (:html :lang "en"
	    (:head 
	     (:meta :http-equiv "Content-Type" 
		    :content    "text/html;charset=utf-8")
	     (:title ,title)
	     (:link :type "text/css" 
		    :rel "stylesheet"
		    :href "/style.css"))
	    (:body
	     (:nav
	      (:li (:a :href "/"
		       "Home"))
	      (:li (:a :href "/object"
		       "Object Writing")))
	     ,@body)
	    (:footer
	     ;; made-with-lisp.jpg is found under Hunchentoot files
	     (:img :src "img/made-with-lisp-logo.jpg")))))

(hunchentoot:define-easy-handler (root :uri "/") ()
  (let* ((noun (fetch-random-word "noun"))
	 (adjective (fetch-random-word "adjective"))
	 (noun-def (fetch-word-definition noun))
	 (adjective-def (fetch-word-definition adjective)))
    (standard-page (:title "Serendipituos Vocable")
		   (:div
		    (:h2 "Serendipituos Vocable")
		    (:p "Write a small story based on this pair of randomly generated noun and adjective.")
		    (:p (:i (format *standard-output* "~a ~a" adjective noun)))
		    (:h3 "Definitions")
		    (:p (format *standard-output* "~a - ~a" adjective adjective-def))
		    (:p (format *standard-output* "~a - ~a" noun noun-def))))))

(hunchentoot:define-easy-handler (object :uri "/object") ()
  (let* ((noun (fetch-random-word "noun"))
	 (noun-def (fetch-word-definition noun)))
    (standard-page (:title "Object Writing - Serendipituos Vocable")
		   (:div
		    (:h2 "Object Writing")
		    (:p "Give yourself strict 10 min and write something about this random object.")
		    (:p (:i (format *standard-output* "~a" noun)))
		    (:h3 "Definitions")
		    (:p (format *standard-output* "~a - ~a" noun noun-def))))))

(defun start ()
  (hunchentoot:start *sv-acceptor*))

(defun stop ()
  (hunchentoot:stop *sv-acceptor*))
