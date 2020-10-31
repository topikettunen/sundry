(in-package :serendipitous-vocable)

(defparameter +wordnik-word+ "https://api.wordnik.com/v4/word.json")
(defparameter +wordnik-words+ "https://api.wordnik.com/v4/words.json")

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
                                       part-of-speech
				       *api-key*))
         (response (dex:get url)))
    (jsown:val (jsown:parse response) "word")))

;;; TODO: This can return multiple definitions so parsing also the rest of them could be useful
(defun fetch-word-definition (word)
  (let* ((url (generate-word-definition-url +wordnik-word+
                                            (format nil "~a/definitions" word)
                                            *api-key*))
         (response (dex:get url)))
    (jsown:val (first (jsown:parse response)) "text")))

