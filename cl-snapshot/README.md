#cl-snapshot

## Getting started

There are two ways to start the programm:

* Load the system in a running lisp session
  1. start sbcl/clisp/ccl/...
  2. load "cl-snapshot" via quicklisp (or cl-snapshot.asd via asdf)
  3. run `(snap:run-server)`
* Run compiled binary (x86_64 only, unless you build it yourself):

```shell
$ ./snap [host1 host2 ...]
```

## Build standalone executable

Make sure sbcl is in your path and quicklisp is installed.
Simly run
```shell
$ ./build.sh
```

## Notes

* The values of `number` and `result` in the snapshot file are controlled via `snap:*number*` and `snap:*result*`
* The port the server listens on can be specified by the optional `:port` parameter
* The server loop has to be interrupted manually
