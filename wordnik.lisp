(in-package :cl-user)
(defpackage cl-wordnik
  (:use :cl))
(in-package :cl-wordnik)

(defun rest-call (host url-path
                  &key params content basic-authorization
                    (method :get)
                    (accept "application/json")
                    (content-type "application/json"))
  "call http-request with basic params and conteent and authorization"
  (multiple-value-bind (stream code)
      (drakma:http-request (format nil "~a~a" host url-path) :parameters params :content content :basic-authorization basic-authorization :accept accept :content-type content-type :want-stream t :method method)
    (if (equal code 200)
        (progn (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
               (cl-json:decode-json stream))
        (format t "HTTP CODE : ~A ~%" code))))
;;
;; NIL
;; * path-url : /account.json/apiTokenStatus
;;
(defun get-account.json-apitokenstatus (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/account.json/apiTokenStatus" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; NIL
;; * path-url : /account.json/authenticate/{username}
;;
(defun get-account.json-authenticate (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /account.json/authenticate/{username}
;;
(defun post-account.json-authenticate (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :post
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; Requires a valid auth_token to be set.
;; * path-url : /account.json/user
;;
(defun get-account.json-user (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/account.json/user" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; NIL
;; * path-url : /account.json/wordLists
;;
(defun get-account.json-wordlists (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/account.json/wordLists" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; The metadata includes a time-expiring fileUrl which allows reading the audio file directly from the API.  Currently only audio pronunciations from the American Heritage Dictionary in mp3 format are supported.
;; * path-url : /word.json/{word}/audio
;;
(defun get-word.json-audio (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/definitions
;;
(defun get-word.json-definitions (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/etymologies
;;
(defun get-word.json-etymologies (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/examples
;;
(defun get-word.json-examples (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/frequency
;;
(defun get-word.json-frequency (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/hyphenation
;;
(defun get-word.json-hyphenation (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/phrases
;;
(defun get-word.json-phrases (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/pronunciations
;;
(defun get-word.json-pronunciations (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/relatedWords
;;
(defun get-word.json-relatedwords (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/scrabbleScore
;;
(defun get-word.json-scrabblescore (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /word.json/{word}/topExample
;;
(defun get-word.json-topexample (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /wordList.json/{permalink}
;;
(defun get-wordlist.json (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /wordList.json/{permalink}/deleteWords
;;
(defun post-wordlist.json-deletewords (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :post
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /wordList.json/{permalink}/words
;;
(defun get-wordlist.json-words (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /wordList.json/{permalink}/words
;;
(defun post-wordlist.json-words (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :post
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /wordLists.json
;;
(defun post-wordlists.json (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/wordLists.json" :params params :content content
                            :basic-authorization basic-authorization
                            :method :post
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; NIL
;; * path-url : /words.json/randomWord
;;
(defun get-words.json-randomword (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/words.json/randomWord" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; NIL
;; * path-url : /words.json/randomWords
;;
(defun get-words.json-randomwords (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/words.json/randomWords" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; NIL
;; * path-url : /words.json/reverseDictionary
;;
(defun get-words.json-reversedictionary (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/words.json/reverseDictionary" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; NIL
;; * path-url : /words.json/search/{query}
;;
(defun get-words.json-search (path-url &key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" path-url :params params :content content
                                              :basic-authorization basic-authorization
                                              :method :get
                                              :accept "application/json"
                                              :content-type "application/json"))
;;
;; NIL
;; * path-url : /words.json/wordOfTheDay
;;
(defun get-words.json-wordoftheday (&key params content basic-authorization)
  (rest-call "https://api.wordnik.com/v4" "/words.json/wordOfTheDay" :params params :content content
                            :basic-authorization basic-authorization
                            :method :get
                            :accept "application/json"
                            :content-type "application/json"))
;;
;; (convert-json #'function "/path" content-json)
;;
(defun convert-json (query-fun path body)
  (multiple-value-bind (code stream head)
      (funcall query-fun path body)
    (if (equal code 200) (progn (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
                                (cl-json:decode-json stream))
        (format t "failed - code : ~a" code))))
