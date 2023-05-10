@namespace "x"
@load "x"
@include "x"
BEGIN {
    for (i = 0; i < 7; i++) print --i
    if (1) {} else if (2) {} else {}
    while (1) {}
    do {} while (1)
    print -7
    f(-7)
    f(a + b * c / d % f ^ j - h)
    f(a[b[1]])
    a += 1
    a -= 1
    a *= 1
    a /= 1
    a %= 1
    a ^= 1
    v = a || b && c
    v = a > 7
    v = a < 7
    v = a >= 7
    v = a <= 7
    v = a ? b : c
    print a ? b : c
    printf ""
    v = a ~ b
    v = a !~ b
    v = (1 + 2)
    v = $NF
    v = !v
    v = a != b
    "cat file" | getline
    print data |& "subprogram"
    print "123" > "file"
    print "123" >> "file"
}
function f(a,   i) {}