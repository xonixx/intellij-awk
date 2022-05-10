function f() {
    a(1  ,2)
    a(111, 2222)
    a(  111  , 2222  )
    a(1111)
    a()
}

function a(used  , <caret>unused2    ) {
    print "hello" used
}