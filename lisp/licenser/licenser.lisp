(defpackage licenser
  (:use :cl)
  (:export #:main))

(in-package :licenser)

(opts:define-opts
  (:name :help
   :description "print this help text"
   :short #\h
   :long "help")
  (:name :list
   :description "list available licenses"
   :short #\l
   :long "list")
  (:name :describe
   :description "describe license"
   :short #\d
   :long "describe"
   :arg-parser #'identity
   :meta-var "LICENSE")
  (:name :name
   :description "license holder name (for MIT)"
   :short #\n
   :long "name"
   :arg-parser #'identity
   :meta-var "NAME")
  (:name :year
   :description "license year (for MIT)"
   :short #\y
   :long "year"
   :arg-parser #'identity
   :meta-var "YEAR"))

(defun decode-output (output-fn)
  (with-input-from-string
      (output (eval output-fn))
    (json:decode-json output)))

(defun list-licenses ()
  (flexi-streams:octets-to-string
   (drakma:http-request "https://api.github.com/licenses")))

(defun parse-license-names (licenses)
  (loop for license in licenses
        collect (cdr (second license))))

(defun parse-license-abbrevs (licenses)
  (loop for license in licenses
        collect (cdr (first license))))

(defun combine-license-name-and-abbrev ()
  (loop
    for name in (parse-license-names (decode-output (list-licenses)))
    for abbrev in (parse-license-abbrevs (decode-output (list-licenses)))
    collect (list name abbrev)))

(defun get-license (license)
  (let ((licenses-url
          (concatenate 'string
                       "https://api.github.com/licenses/"
                       license)))
    `(flexi-streams:octets-to-string
      (drakma:http-request ,licenses-url))))

(defun parse-license-body (license)
  (cdr (first (nthcdr 11 (decode-output (get-license license))))))

(defun parse-license-description (license)
  (cdr (seventh (decode-output (get-license license)))))

(defun mit-replace-year-placeholder (year license-body)
  (cl-ppcre:regex-replace-all "\\[year\\]" license-body year))

(defun mit-replace-name-placeholder (name license-body)
  (cl-ppcre:regex-replace-all "\\[fullname\\]" license-body name))

(defun print-available-licenses (licenses)
  (format t "Available licenses:~%~%")
  (loop
    for license in licenses
    do (format t "~a - ~a~%" (car (cdr license)) (car license))))

(defun print-license-description (license)
  (format t "~a~%" (parse-license-description license)))

(defun replace-mit-placeholders (name year license)
  (mit-replace-year-placeholder year
                                (mit-replace-name-placeholder name
                                                              license)))

(defun print-mit-license (name year license)
  (format t "~a~%" (replace-mit-placeholders name year license)))

(defun print-license (license)
  (format t "~a~%" license))

(defun main ()
  (multiple-value-bind (options free-args)
      (opts:get-opts)
    (if (getf options :help)
        (progn
          (opts:describe
           :prefix "Licenser - Usage: licenser [OPTIONS] COMMAND"
           :args "[keywords]")
          (opts:exit)))
    (if (getf options :list)
        (print-available-licenses (combine-license-name-and-abbrev)))
    (if (getf options :describe)
        (let ((license (getf options :describe)))
          (print-license-description license)))
    (let ((license (parse-license-body (car free-args))))
      (if (string= (car free-args) "mit")
          (progn
            (print-mit-license (getf options :name) (getf options :year) license)
            (opts:exit))))
    (print-license license)))
