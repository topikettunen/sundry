# serendipitous-vocable

Simple web application for generating writing exercises powered by Common
Lisp. Mainly done as a test for Common Lisp's capabilities in the web.

## Installation

Clone repository under `local-projects` and:

``` common-lisp
CL-USER> (ql:quickload :sv)

CL-USER> (setf sv.words:*api-key* "YOUR_WORDNIK_API_KEY")

CL-USER> (sv:start :port 8080)
```

When finished:

``` common-lisp
CL-USER> (sv:stop)
```

## Author

* Topi Kettunen

## Copyright

Copyright (c) 2020 Topi Kettunen
