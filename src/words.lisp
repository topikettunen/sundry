(in-package :cl-user)
(defpackage vokaabeli.words
  (:use :cl)
  (:export :*api-key*
           :fetch-random-word
	   :fetch-word-definition))
(in-package :vokaabeli.words)

(defconstant +wordnik-word+ "https://api.wordnik.com/v4/word.json")
(defconstant +wordnik-words+ "https://api.wordnik.com/v4/words.json")

(defvar *api-key* nil)
(defvar *random-word-params* "hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1")
(defvar *word-definition-params* "limit=200&includeRelated=false&useCanonical=false&includeTags=false")


;;; TODO: These could be done in little bit more "cool" way. Also handle nil api-key.
(defun generate-random-word-url (root endpoint part-of-speech)
  (if (not *api-key*)
      (let ((params *random-word-params*))
	(format nil "~a/~a?~a&~a&api_key=~a" root endpoint part-of-speech params *api-key*))
      (format t nil "Oops... vokaabeli.words:*api-key* not set...")))

(defun generate-word-definition-url (root endpoint)
  (if (not *api-key*)
      (let ((params *word-definition-params*))
	(format nil "~a/~a?~a&api_key=~a" root endpoint params *api-key*))
      (format t nil "Oops... vokaabeli.words:*api-key* not set...")))

(defun fetch-random-word (part-of-speech)
  (let* ((url (generate-random-word-url +wordnik-words+
                                       "randomWord"
                                       part-of-speech))
         (response (dex:get url)))
    (jsown:val (jsown:parse response) "word")))

;;; TODO: This can return multiple definitions so parsing also the rest of them could be useful
(defun fetch-word-definition (word)
  (let* ((url (generate-word-definition-url +wordnik-word+
                                            (format nil "~a/definitions" word)))
         (response (dex:get url)))
    (jsown:val (first (jsown:parse response)) "text")))
