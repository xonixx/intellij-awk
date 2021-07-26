BEGIN {
	a = 5
	printf "a = %d, SYMTAB[\"a\"] = %d\n", a, SYMTAB["a"]
	SYMTAB["a"] = 4
	printf "a = %d, SYMTAB[\"a\"] = %d\n", a, SYMTAB["a"]
}
