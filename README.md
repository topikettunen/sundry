# trivial-constant-time

**WORK IN PROGRESS**

## Usage

Attempt to implement Go's subtle module in providing utilities for contanst-time
cryptographic implementations.

### Warning

Big reason behind making this code was to test Common Lisp's cryptographic
capabilities so code is definitely not production-ready and far from optimized
and only meant for specific use cases.

*USE AT YOUR OWN RISK! NO WARRANTY!*

## Installation

At the moment this is not available in Quicklisp so best way to get started in
using this is to clone it to your `local-projects`and load it from there.

```
CL-USER> (ql:quickload :trivial-constant-time)
```

## Author

* Topi Kettunen (topi@kettunen.io)

## Copyright

Copyright (c) 2020 Topi Kettunen (topi@kettunen.io)

## License

Licensed under the MIT License.
