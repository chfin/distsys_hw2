(ql:quickload "cl-snapshot")
(sb-ext:save-lisp-and-die "snap"
			  :toplevel #'snap::sb-main
			  :executable t
			  :purify t)
