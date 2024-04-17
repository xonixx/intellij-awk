BEGIN {
    a = "fname"
    b("fname")
    substr("fname")
    print "fname"
}
function b() {}
function fname<caret>() {}