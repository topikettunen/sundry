(in-package :cl-user)
(defpackage trivial-constant-time
  (:use :cl)
  (:export :compare
           :select
	   :byte-eq
           :eq*
	   :copy
           :less-or-eq))
(in-package :trivial-constant-time)

(defun uint (b int)
  (coerce int `(unsigned-byte ,b)))

(defun compare (x y)
  "Returns 1 if both X and Y have equal contents and 0 otherwise."
  (if (= (length x) (length y))
      (let ((v nil))
	(dolist (i x)
	  (let ((pos (position i x)))
	    (setq v (logior (logxor (nth pos x) (nth pos y))))))
	(if v
	    (byte-eq (uint 8 v) 0)
	    (byte-eq (uint 8 0) 0)))
      0))

;;; TODO
(defun select (v x y)
  "Returns X if V equals 1 and y if V equals to 0. With other values of V,
the behaviour is undefined"
  (logior (logand (logxor (- v 1)) x) (logand (- x 1) y)))

(defun byte-eq (x y)
  "Return 1 if X equals Y, 0 otherwise."
  (declare (type (unsigned-byte 8) x y))
  (let ((val (ash (- (uint 32 (logxor x y)) 1) -31)))
    (if (< val 0)
	1
	0)))

(defun eq* (x y)
  "Return 1 if X equals Y, 0 otherwise."
  (declare (type (unsigned-byte 32) x y))
  (let ((val (ash (- (logxor x y) 1) -63)))
    (if (< val 0)
	1
	0)))

;;; TODO
(defun copy (v x y)
  "Copy contents of Y to X (which are lists of equal lenghts) if V equals to 1.
If V equals to 0, x is left unchanged. With other values of V behaviour is undefined."
  (when (= (length x) (length y))
    (let ((xmask (- v 1))
	  (ymask (- v 1)))
      (dolist (i x)
	(let* ((pos (position i x))
	       (v (logior (logand (nth pos x) xmask) (logand (nth pos y) ymask))))
	  (format t "~A" v)
	  (setf x (set-nth x pos v))))
      (values x y))))

;;; TODO
(defun less-or-eq (x y)
  "Return 1 if X is smaller or equal to Y and 0 otherwise. Undefined behaviour if X or Y are negative"
  (let ((gtb (logand x (logxor y)))
	(ltb (logand (logxor x) y)))
    ;; Fix undefined behaviour if x or y are smaller than (2^31 - 1)
    ;; See: https://github.com/golang/go/pull/42687.
    (setq ltb (logior ltb (ash ltb -1)))
    (setq ltb (logior ltb (ash ltb -2)))
    (setq ltb (logior ltb (ash ltb -4)))
    (setq ltb (logior ltb (ash ltb -16)))
    (let ((bit (logand gtb (logxor ltb))))
      (setq bit (logior bit (ash bit -1)))
      (setq bit (logior bit (ash bit -2)))
      (setq bit (logior bit (ash bit -4)))
      (setq bit (logior bit (ash bit -16)))
      (logand (logxor bit) 1))))

(defun set-nth (list n val)
  (if (> n 0)
      (cons (car list)
            (set-nth (cdr list) (- 1 n) val))
      (cons val (cdr list))))
