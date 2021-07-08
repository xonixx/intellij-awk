BEGIN {
    @name(123)
}

function f(a,    i) {
    f1(name)
    name++
    print "name: " name<caret>
}

function f2() {
    name = f3(name)
}

END {
    print toupper(++name)
    @  name()
}