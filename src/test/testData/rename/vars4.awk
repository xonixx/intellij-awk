BEGIN {
    name=1
    name++
    print name+1
}

function f(a,    i) {
    f1(name)
    name++
    print "name: " name<caret>
}