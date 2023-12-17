BEGIN {
    Arr["key1"] = "val1"
    Arr["key2"]
    Arr["key3"] = "val3"
}
function f() {
    split("", Arr)
}