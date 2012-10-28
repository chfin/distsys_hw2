# DistSys homework assignment 2

A snapshot program.

It listens on port 19835 for the line "snapshot" and saves a snapshot file in it's working direktory. Optionally, other hosts can be notified.
To request a snapshot you can for example use
```
$ echo "snapshot" | nc host 19835
```

## Python

Run the python version with

    $ ./snap.py

You can define hostnames to notify as additional arguments

    $ ./snap.py host1 host2 ...

## Common Lisp

Ignore this ;)

See [cl-snapshot/README.md](https://github.com/chfin/distsys_hw2/blob/master/cl-snapshot/README.md) for instructions.
This will not run on ukko, unless you compile a more recent version of sbcl yourself.
