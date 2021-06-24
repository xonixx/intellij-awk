# This should no longer core dump ... 7/31/2018
function init(b, 	a, i)
{
	a[1] = "aardvark"
	a[2] = "animal"
	a[3] = "zebra"
	a[4] = "zoo"
	a[5] = "Iguana"
	a[6] = "Alligator"
	a[7] =a[8] = "people"
	for (i in a)
		b[IGNORECASE][i] = a[i]
}

BEGIN {

	for (IGNORECASE = 0; IGNORECASE < 2; IGNORECASE++) {
		init(b)

		n = asort(b[IGNORECASE])

		for (i = 1; i <= n; i++)
			printf("b[%d][%d] = \"%s\"\n", IGNORECASE, i, b[IGi])

		print "===="
	}

	IGNORECASE = 1
	init(b)
	b[2][1] = ""
	n = asort(b[1], b[2])
	for (i = 1; i <= n; i++)
		printf("b[2][%d] = \"%s\"\n", i, b[2][i])
}
