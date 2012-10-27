;;;; package.lisp

(defpackage #:cl-snapshot
  (:use #:cl #:iolib #:inferior-shell)
  (:nicknames #:snap)
  (:export #:*outgoing* #:*number* #:*result*
	   #:run-server))

