;;;; cl-snapshot.asd

(asdf:defsystem #:cl-snapshot
  :serial t
  :description "Describe cl-snapshot here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:iolib #:inferior-shell)
  :components ((:file "package")
               (:file "cl-snapshot")))
