(in-package :cl-user)
(defpackage vokaabeli.words
  (:use :cl
	:vokaabeli.conditions)
  (:export :*wordnik-api-key*
           :fetch-random-word
	   :fetch-word-definition))
(in-package :vokaabeli.words)

(defvar *wordnik-api-key* nil)

(defun make-random-word-uri (part-of-speech)
  (if *wordnik-api-key*
      (quri:render-uri (quri:make-uri :scheme "https"
				      :host "api.wordnik.com"
				      :path "/v4/words.json/randomWord"
				      :query `(("includePartOfSpeech" . ,part-of-speech)
					       ("hasDictionaryDef" . "true")
					       ("maxCorpusCount" . "-1")
					       ("minDictionaryCount" . "1")
					       ("maxDictionaryCount" . "-1")
					       ("minLength" . "5")
					       ("maxLength" . "-1")
					       ("api_key" . ,*wordnik-api-key*))))
      (error 'api-key-not-set :api-key *wordnik-api-key*)))

(defun make-word-definition-uri (word)
  (if *wordnik-api-key*
      (quri:render-uri (quri:make-uri :scheme "https"
				      :host "api.wordnik.com"
				      :path (format nil "/v4/word.json/~a/definitions" word)
				      :query `(("limit" . "200")
					       ("includeRelated" . "false")
					       ("useCanonical" . "false")
					       ("includeTags" . "false")
					       ("api_key" . ,*wordnik-api-key*))))
      (error 'api-key-not-set :api-key *wordnik-api-key*)))

(defun fetch-random-word (part-of-speech)
  (let* ((url (make-random-word-uri part-of-speech))
         (response (dex:get url)))
    (jsown:val (jsown:parse response) "word")))

;;; I'm interested on the first description for now
(defun fetch-word-definition (word)
  (let* ((url (make-word-definition-uri word))
         (response (dex:get url)))
    (jsown:val (first (jsown:parse response)) "text")))
