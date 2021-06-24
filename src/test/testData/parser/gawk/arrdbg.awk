function check(x, exptype,   f) {
	f[x]
	printf "array_f subscript [%s]\n", x
	printf "array_f subscript [%s]\n", x > okfile
	adump(f, -1)
	printf "    array_func: %s_array_func\n", exptype > okfile
}

BEGIN {
	check(3.0, "cint")
	check(-3, "int")
	check("3.0", "str")
	split(" 3", f, "|")	# create a maybe_num value
	check(f[1], "str")
	check("0", "cint")
	check("-1", "int")
}
