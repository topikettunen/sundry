FROM ubuntu:latest

COPY Makefile licenser.asd licenser.lisp /

RUN apt-get update && apt-get install -y curl sbcl make && \
        curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp && \
        sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
        --eval '(quicklisp-quickstart:install :path "common-lisp")' \
        --quit && \
        echo '#-quicklisp\n\
  (let ((quicklisp-init #P"/common-lisp/setup.lisp"))\n\
    (when (probe-file quicklisp-init)\n\
      (load quicklisp-init)))\n' > /root/.sbclrc && \
        make

ENTRYPOINT [ "/licenser" ]
