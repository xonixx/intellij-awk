function dumparray(name, array,		i)
{
	if (name == "ENVIRON" || name == "PROCINFO")
		return

	for (i in array)
		if (isarray(array[i]))
			dumparray(name "[" i "]", array[i])
		else
			printf("%s[%s] = %s\n", name, i, array[i])
}

BEGIN {
	a[1] = 1
	a[2][1] = 21
	for (i in SYMTAB)
		if (isarray(SYMTAB[i]))
			dumparray(i, SYMTAB[i])
		else
			printf("SYMTAB[\"%s\"] = \"%s\"\n", i, SYMTAB[i])
}
