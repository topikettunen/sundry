(in-package :cl-user)
(defpackage vokaabeli.translate
  (:use :cl
	:vokaabeli.conditions)
  (:export :*translate-api-key*
	   :translate-to-fi))
(in-package :vokaabeli.translate)

(defvar *translate-api-key* nil)

(defun make-translate-uri (q)
  (if *translate-api-key*
      (quri:render-uri (quri:make-uri :scheme "https"
				      :host "translation.googleapis.com"
				      :path "/language/translate/v2"
				      :query `(("key" . ,*translate-api-key*)
					       ("q" . ,q)
					       ;; In vokaabeli target is always fi and source is en.
					       ("target" . "fi")
					       ("source" . "en"))))
      (error 'api-key-not-set :api-key *translate-api-key*)))

(defun translate-to-fi (q)
  (let* ((uri (make-translate-uri q))
	 (response (dex:post uri)))
    (jsown:val (first (jsown:val (jsown:val (jsown:parse response)
					   "data")
				"translations"))
	      "translatedText")))
