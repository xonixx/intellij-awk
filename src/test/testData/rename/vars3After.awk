BEGIN {
    name=1
    name++
    print name+1
}

function f(a, newName,    i) {
    f1(newName)
    newName++
    print "name: " newName
}