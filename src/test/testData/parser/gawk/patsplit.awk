BEGIN {
	FALSE = 0
	TRUE = 1

	fpat[1] = "([^,]*)|(\"[^\"]+\")"
	fpat[2] = fpat[1]
	fpat[3] = fpat[1]
	fpat[4] = "aa+"
	fpat[5] = fpat[4]

	data[1] = "Robbins,,Arnold,"
	data[2] = "Smith,,\"1234 A Pretty Place, NE\",Sometown,NY,12345-6789,USA"
	data[3] = "Robbins,Arnold,\"1234 A Pretty Place, NE\",Sometown,NY,12345-6789,USA"
	data[4] = "bbbaaacccdddaaaaaqqqq"
	data[5] = "bbbaaacccdddaaaaaqqqqa" # should get trailing qqqa

	for (j = 1; j in data; j++) {
		printf("Splitting: <%s>\n", data[j])
		n = patsplit(data[j], fields, fpat[j], seps)
		print "n =", n
		for (i = 1; i <= n; i++)
			printf("fields[%d] = <%s>\n", i, fields[i])
		for (i = 0; i in seps; i++)
			printf("seps[%s] = <%s>\n", i, seps[i])
	}
}
