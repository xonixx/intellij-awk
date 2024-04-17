BEGIN {
    b("fname")
}

function b(f) { @f() }

function <caret>fname() {}