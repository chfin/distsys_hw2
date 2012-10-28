#cl-snapshot

## Getting started

1. start sbcl/clisp/ccl/...
2. load "cl-snapshot" via quicklisp (or cl-snapshot.asd via asdf)
3. run `(snap:run-server)`

## Notes

* The values of `number` and `result` in the snapshot file are controlled via `snap:*number*` and `snap:*result*`
* The port the server listens on can be specified by the optional `:port` parameter
* The server loop has to be interrupted manually
