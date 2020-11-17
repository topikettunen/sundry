(in-package :cl-user)
(defpackage vokaabeli.web
  (:use :cl
        :caveman2
        :vokaabeli.config
        :vokaabeli.view
	:vokaabeli.words
	:vokaabeli.translate)
  (:export :*web*))
(in-package :vokaabeli.web)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (let* ((noun (fetch-random-word "noun"))
	 (adjective (fetch-random-word "adjective"))
	 (noun-def (fetch-word-definition noun))
	 (adjective-def (fetch-word-definition adjective))
	 (noun-fi (translate-to-fi noun))
	 (adjective-fi (translate-to-fi adjective))
	 (noun-def-fi (translate-to-fi noun-def))
	 (adjective-def-fi (translate-to-fi adjective-def)))
    (render #P"index.html"
	    `(:adjective ,adjective
	      :noun ,noun
	      :adj-def ,adjective-def
	      :noun-def ,noun-def
	      :adjective-fi ,adjective-fi
	      :noun-fi ,noun-fi
	      :adjective-def-fi ,adjective-def-fi
	      :noun-def-fi ,noun-def-fi))))

(defroute "/object-writing" ()
  (let* ((noun (fetch-random-word "noun"))
	 (noun-def (fetch-word-definition noun))
	 (noun-fi (translate-to-fi noun))
	 (noun-def-fi (translate-to-fi noun)))
    (render #P"object-writing.html"
	    `(:noun ,noun
	      :noun-def ,noun-def
	      :noun-fi ,noun-fi
	      :noun-def-fi ,noun-def-fi))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
