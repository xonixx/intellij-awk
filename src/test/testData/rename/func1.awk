BEGIN {
    name<caret>()
}

function name() {
    name()
}

function f2() {
    name()
    name("arg")
    print f3(name()+1)
}

