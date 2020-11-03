# serendipitous-vocable

Simple web application for generating writing exercises powered by Common
Lisp. Mainly done as a test for Common Lisp's capabilities in the web.

## Installation

``` common-lisp
(ql:quickload :sv)

(setf sv.words:*api-key* "YOUR_WORDNIK_API_KEY")

(sv:start :port 8080)
```

When finished:

``` common-lisp
(sv:stop)
```

## Author

* Topi Kettunen

## Copyright

Copyright (c) 2020 Topi Kettunen
