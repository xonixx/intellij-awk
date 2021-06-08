BEGIN {
    newName()
}

function newName() {
    newName()
}

function f2() {
    newName()
    newName("arg")
    print f3(newName()+1)
}

