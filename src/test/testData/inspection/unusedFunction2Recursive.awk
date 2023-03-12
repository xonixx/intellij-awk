function <caret>a() {
    print "I'm unused recursive function"
    a()
    b()
}

function b() {
    print "I'm used"
}