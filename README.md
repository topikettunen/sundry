# vokaabeli

Simple web application for generating writing exercises powered by Common
Lisp. Mainly done as a test for Common Lisp's capabilities in the web.

## Installation

``` common-lisp
CL-USER> (ql:quickload :vokaabeli)
CL-USER> (setf vokaabeli.words:*wordnik-api-key* "YOUR_WORDNIK_API_KEY")
CL-USER> (setf vokaabeli.translate:*translate-api-key* "YOUR_GOOGLE_API_KEY")
CL-USER> (vokaabeli:start :port 8080)
```

When finished:

``` common-lisp
CL-USER> (vokaabeli:stop)
```

## Author

* Topi Kettunen

## Copyright

Copyright (c) 2020 Topi Kettunen
