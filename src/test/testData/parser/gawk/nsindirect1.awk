@namespace "test"

BEGIN {
	bar = 3
}

@namespace "awk"

BEGIN {
	print "before change, direct =", test::bar, "indirect =", SYMTAB["test::bar"]
	SYMTAB["test::bar"] = 4
	print "after change, direct =", test::bar, "indirect =", SYMTAB["test::bar"]
}
