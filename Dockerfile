FROM sbcl:latest

COPY Makefile licenser.asd licenser.lisp /

RUN apt-get install build-essential

RUN make

ENTRYPOINT [ "/licenser" ]
