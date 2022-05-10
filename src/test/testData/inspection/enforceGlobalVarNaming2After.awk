function initFunc() {
    VarName = 1
}
BEGIN {
    initFunc()
}
END {
    print VarName
}