#!/usr/bin/env python

from commands import getoutput
import socket
from SocketServer import TCPServer, StreamRequestHandler
import sys

#useless global variables:
number = 4
result = 5

#host list:
outgoing = []

class Handler(StreamRequestHandler):
    def handle(self):
        msg = self.rfile.readline().strip().lower()
        if (msg == 'snapshot'):
            snapshot()
            map (notify, outgoing)

def run_server(port=19835):
    serv = TCPServer(('', port), Handler)
    serv.allow_reuse_address = True
    try:
        serv.serve_forever()
    except KeyboardInterrupt:
        print 'interrupted...'
    finally:
        serv.socket.close()

def snapshot():
    print 'Taking snapshot'
    
    #get data from outside
    hostname = getoutput('hostname')
    date = getoutput('date +%d%m%Y')
    uptime = getoutput('uptime').strip()

    filename = hostname + '-' + date + '.txt'
    print 'writing to', filename
    f = open(filename, 'w')
    wpair (f, 'number', number)
    wpair (f, 'result', result)
    wpair (f, 'hostname', hostname)
    wpair (f, 'time', '"'+uptime+'"')
    f.close()

def wpair(f, key, val):
    f.write (key+' = '+str(val)+'\n')

def notify(host):
    print 'Notifying', host
    port = 19835
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((host, port))
    s.send("snapshot\n")
    s.close()

def main():
    global outgoing
    outgoing = sys.argv[1:]
    run_server()

if __name__ == "__main__":
    main()
