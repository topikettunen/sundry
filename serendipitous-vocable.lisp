(defpackage serendipitous-vocable
   (:use :cl))

(in-package :serendipitous-vocable)

(defparameter +wordnik-word+ "https://api.wordnik.com/v4/word.json")
(defparameter +wordnik-words+ "https://api.wordnik.com/v4/words.json")

(defparameter *api-key* nil) 

;;; TODO: These could be done in little bit more "cool" way. Also handle nil api-key.
(defun generate-random-word-url (root endpoint part-of-speech)
  (let ((params "hasDictionaryDef=true&maxCorpusCount=-1&minDictionaryCount=1&maxDictionaryCount=-1&minLength=5&maxLength=-1"))
    (format nil "~a/~a?~a&~a&api_key=~a" root endpoint part-of-speech params *api-key*)))

(defun generate-word-definition-url (root endpoint)
  (let ((params "limit=200&includeRelated=false&useCanonical=false&includeTags=false"))
    (format nil "~a/~a?~a&api_key=~a" root endpoint params *api-key*)))

(defun fetch-random-word (part-of-speech)
  (let* ((url (generate-random-word-url +wordnik-words+
                                       "randomWord"
                                       *api-key*
                                       part-of-speech))
         (response (dex:get url)))
    (jsown:val (jsown:parse response) "word")))

;;; TODO: This can return multiple definitions so parsing also the rest of them could be useful
(defun fetch-word-definition (word)
  (let* ((url (generate-word-definition-url +wordnik-word+
                                            (format nil "~a/definitions" word)
                                            *api-key*))
         (response (dex:get url)))
    (jsown:val (first (jsown:parse response)) "text")))

(defun generate ()
  (setf *api-key* (uiop:getenv "WORDNIK_API_KEY"))
  (let ((noun (fetch-random-word "noun" *api-key*))
         (adjective (fetch-random-word "adjective" *api-key*)))
    (format t "Write small story based on this pair of randomly generated noun and adjective.~%~%")
    (format t "~C~a ~a~%~%" #\tab adjective noun)
    (let ((noun-def (fetch-word-definition noun api-key))
          (adjective-def (fetch-word-definition adjective api-key)))
      (format t "~a:~%~C~a~%~%" noun #\tab noun-def)
      (format t "~a:~%~C~a~%" adjective #\tab adjective-def))))
