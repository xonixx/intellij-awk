BEGIN { f() }
# dup functions should not imply unused
function f<caret>() {}
function f() {}