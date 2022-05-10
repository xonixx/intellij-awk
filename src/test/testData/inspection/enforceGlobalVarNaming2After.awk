function initFunc() {
    Var = 1
}
BEGIN {
    initFunc()
}
END {
    print Var
}