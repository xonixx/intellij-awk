function function1()
{
	print "function1"
}

BEGIN { 
	an_array[1] = 1

	for (i in PROCINFO["identifiers"])
	      printf("%s -> %s\n", i, PROCINFO["identifiers"][i]) | "sort"
	close("sort")
}
