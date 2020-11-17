(in-package :cl-user)
(defpackage vokaabeli.translate
  (:use :cl))
(in-package :vokaabeli.translate)

(defun translate-to-target (q target key &optional source)
  (let ((translate-api-url
          (concatenate 'string
                       "https://translation.googleapis.com/language/translate/v2?key="
                       key)))
    (if source
	;; Refactor to dexador
        `(flexi-streams:octets-to-string
          (drakma:http-request ,translate-api-url
                               :method :post
                               :parameters '(("q" . ,q)
                                             ("target" . ,target)
                                             ("source" . ,source))))
        `(flexi-streams:octets-to-string
          (drakma:http-request ,translate-api-url
                               :method :post
                               :parameters '(("q" . ,q)
                                             ("target" . ,target)))))))

;;; jsown for decoding
(defun decode-output (q target key)
  (with-input-from-string
      (output (eval (translate-to-target q target key)))
    (json:decode-json output)))

;;; jsown for parsing
(defun parse-translated-text (output)
  (cdr (first (second (second (first output))))))
