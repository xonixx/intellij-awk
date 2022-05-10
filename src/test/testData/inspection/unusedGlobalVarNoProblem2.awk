BEGIN {
    init1()
}
function init1() {
    split("", <caret>GlobalArr)
}
function a() {
    print GlobalArr["k"]
}