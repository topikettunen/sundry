(in-package :cl-user)
(defpackage sv.web
  (:use :cl
        :caveman2
        :sv.config
        :sv.view
	:sv.words)
  (:export :*web*))
(in-package :sv.web)

;; for @route annotation
(syntax:use-syntax :annot)

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
	 (adjective-def (fetch-word-definition adjective)))
    (render #P"index.html"
	    `(:adjective ,adjective
	      :noun ,noun
	      :adj-def ,adjective-def
	      :n-def ,noun-def))))

(defroute "/object-writing" ()
  (let* ((noun (fetch-random-word "noun"))
	 (noun-def (fetch-word-definition noun)))
    (render #P"object-writing.html"
	    `(:noun ,noun
	      :noun-def ,noun-def))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
