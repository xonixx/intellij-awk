function init(b, a, i)
{
	delete a

	a["aardvark"] = 1
	a["animal"] = 2
	a["zebra"] = 3
	a["zoo"] = 4
	a["Iguana"] = 5
	a["Alligator"] = 6
	a["Nouns"] = 7
	a["people"] = 8
	for (i in a)
		b[IGNORECASE][i] = a[i]
}

BEGIN {

	for (IGNORECASE = 0; IGNORECASE < 2; IGNORECASE++) {
		init(b)

		n = asorti(b[IGNORECASE])

		for (i = 1; i <= n; i++)
			printf("b[%d][%d] = \"%s\"\n", IGNORECASE, i, b[IGNORECASE][i])

		print "============"

	}
	
	n = asorti(b)
	for (i = 1; i <= n; i++)
		printf("b[%d] = \"%s\"\n", i, b[i])

}
