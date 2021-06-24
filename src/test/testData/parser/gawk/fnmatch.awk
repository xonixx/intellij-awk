@load "fnmatch"

BEGIN {
	# can't print the values; they vary from system to system
	for (i in FNM)
		printf("\"%s\" is an element in FNM\n", i)
	# can't even print this
	# print "FNM_NOMATCH =", FNM_NOMATCH 

	printf("fnmatch(\"*.a\", \"foo.a\", 0)  = %d\n", fnmatch("*.a", "foo.a", 0) )
	if (fnmatch("*.a", "foo.c", 0) == FNM_NOMATCH)
		printf("fnmatch(\"*.a\", \"foo.c\", 0) == FNM_NOMATCH\n")
}
