LISP ?= sbcl

build:
	$(LISP) --load licenser.asd \
	    	--eval '(ql:quickload :licenser)' \
		--eval '(asdf:make :licenser)' \
		--eval '(quit)'
