(ql:quickload "cl-snapshot")
#-sb-core-compression
(sb-ext:save-lisp-and-die "snap"
			  :toplevel #'snap::sb-main
			  :executable t
			  :purify t)
#+sb-core-compression
(sb-ext:save-lisp-and-die "snap"
			  :toplevel #'snap::sb-main
			  :executable t
			  :purify t
			  :compression t)
