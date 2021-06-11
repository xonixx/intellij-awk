BEGIN {
}

function f(a,    i) {
    f1(newName)
    newName++
    print "name: " newName<caret>
}

function f2() {
    newName = f3(newName)
}

END {
    print toupper(++newName)
}