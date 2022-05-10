BEGIN {
    <caret>arr["key1"] = "val1"
    arr["key2"]
    arr["key3"] = "val3"
}
function f() {
    split("",arr)
}