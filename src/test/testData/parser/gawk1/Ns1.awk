


@namespace "aaa"

function f() {  a() }

@include "bbb"

@load "ccc"

function aaa::f() { bbb::a="A" }

function a() {print "A"}
BEGIN { b="a"; @   awk::b()  }
BEGIN { print awk::NF  }
BEGIN { print NF  }

@  namespace "aaa"

function f() { print "F" }

@ namespace "bbb"

BEGIN {
    aaa::f()
    a[0]="a"
    a[1]="b"
    a[2]="c"

    for(aaa::i in a) print aaa::i, a[aaa::i]
}
