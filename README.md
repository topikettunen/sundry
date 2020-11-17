# vokaabeli

Simple web application for generating writing exercises powered by Common
Lisp. Mainly done as a test for Common Lisp's capabilities in the web.

## Installation

``` common-lisp
(ql:quickload :vokaabeli)

(setf vokaabeli.words:*api-key* "YOUR_WORDNIK_API_KEY")

(vokaabeli:start :port 8080)
```

When finished:

``` common-lisp
(vokaabeli:stop)
```

## Author

* Topi Kettunen

## Copyright

Copyright (c) 2020 Topi Kettunen
