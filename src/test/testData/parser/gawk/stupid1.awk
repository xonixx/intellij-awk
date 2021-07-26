BEGIN {
	abc("varname")
	varname
}

func abc(n)
{
	if (n in SYMTAB) {
		print "before"
		is = SYMTAB[n]
		print "after"
	}
}
