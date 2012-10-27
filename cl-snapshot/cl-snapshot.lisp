;;;; cl-snapshot.lisp

(in-package #:cl-snapshot)

(defvar *port* 19835
  "global default port")

(defvar *outgoing* nil
  "list of outgoing hosts")

(defvar *number* 4
  "useless variable to be stored in the snapshot")

(defvar *result* 5
  "useless variable to be stored in the snapshot")

(defun snapshot ()
  (let* ((hostname (run/ss "hostname"))
	 (date (run/ss "date +%d%m%Y"))
	 (uptime (run/ss "uptime"))
	 (filename (merge-pathnames (format nil "~a-~a.txt" hostname date))))
    (format t "Writing snapshot to ~a~%" filename)
    (with-open-file (stream filename
			    :direction :output
			    :if-exists :overwrite
			    :if-does-not-exist :create)
      (format stream "number = ~a~%result = ~a~%hostname = ~a~%time = ~s~%"
	    *number* *result* hostname uptime))))

(defun notify (host &key (port *port*))
  (format t "Notifying ~a~%" host)
  (with-open-socket
      (socket :connect :active
              :address-family :internet
              :type :stream
              :external-format '(:utf-8 :eol-style :lf)
              :ipv6 nil)
    (connect socket (lookup-hostname host) :port port :wait t)
    (format t "Connected to server ~A:~A from my local connection at ~A:~A!~%"
            (remote-name socket) (remote-port socket)
            (local-name socket) (local-port socket))
    (format socket "snapshot~%")
    (finish-output socket)))

(defun run-server (&key (port *port*))
  (with-open-socket
      (server :connect :passive
	      :address-family :internet
	      :type :stream
	      :ipv6 nil
	      :external-format '(:utf-8 :eol-style :lf))
    (format t "Created socket: ~a[fd=~a]~%" server (socket-os-fd server))
    
    (bind-address server +ipv4-unspecified+ :port port :reuse-addr t)
    (format t "Bound socket: ~a~%" server)
    
    (listen-on server :backlog 5)
    (format t "Listening on socket bound to: ~A:~A~%"
            (local-host server)
            (local-port server))
    (loop
       (format t "Waiting to accept a connection...~%")
       (with-accept-connection (client server :wait t)
         (multiple-value-bind (who rport)
             (remote-name client)
           (format t "Got a connnection from ~A:~A!~%" who rport))
	 (when (string-equal (read-line client) "snapshot")
	   ;;call snapshot function
	   (snapshot)
	   ;;notify other nodes
	   (mapcar #'notify *outgoing*))))))
