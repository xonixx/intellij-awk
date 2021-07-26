BEGIN {
	false = 0
	true = 1

	fpat[1] = "([^,]*)|(\"[^\"]+\")"
	fpat[2] = fpat[1]
	fpat[3] = fpat[1]
	fpat[4] = "aa+"
	fpat[5] = fpat[4]
	fpat[6] = "[a-z]"

	data[1] = "Robbins,,Arnold,"
	data[2] = "Smith,,\"1234 A Pretty Place, NE\",Sometown,NY,12345-6789,USA"
	data[3] = "Robbins,Arnold,\"1234 A Pretty Place, NE\",Sometown,NY,12345-6789,USA"
	data[4] = "bbbaaacccdddaaaaaqqqq"
	data[5] = "bbbaaacccdddaaaaaqqqqa" # should get trailing qqqa
	data[6] = "aAbBcC"

	for (i = 1; i in data; i++) {
		printf("Splitting: <%s>\n", data[i])
		n = mypatsplit(data[i], fields, fpat[i], seps)
		m = patsplit(data[i], fields2, fpat[i], seps2)
		print "n =", n, "m =", m
		if (n != m) {
			printf("ERROR: counts wrong!\n") > "/dev/stderr"
			exit 1
		}
		for (j = 1; j <= n; j++) {
			printf("fields[%d] = <%s>\tfields2[%d] = <%s>\n", j, fields[j], j, fields2[j])
			if (fields[j] != fields2[j]) {
				printf("ERROR: data %d, field %d mismatch!\n", i, j) > "/dev/stderr"
				exit 1
			}
		}
		for (j = 0; j in seps; j++) {
			printf("seps[%d] = <%s>\tseps2[%d] = <%s>\n", j, seps[j], j, seps2[j])
			if (seps[j] != seps2[j]) {
				printf("ERROR: data %d, separator %d mismatch!\n", i, j) > "/dev/stderr"
				exit 1
			}
		}
	}
}

function mypatsplit(string, array, pattern, seps,
			eosflag, non_empty, nf) # locals
{
	delete array
	delete seps
	if (length(string) == 0)
		return 0

	eosflag = non_empty = false
	nf = 0
	while (match(string, pattern)) {
		if (RLENGTH > 0) {	# easy case
			non_empty = true
			if (! (nf in seps)) {
				if (RSTART == 1)	# match at front of string
					seps[nf] = ""
				else
					seps[nf] = substr(string, 1, RSTART - 1)
			}
			array[++nf] = substr(string, RSTART, RLENGTH)
			string = substr(string, RSTART+RLENGTH)
			if (length(string) == 0)
				break
		} else if (non_empty) {
			# last match was non-empty, and at the
			# current character we get a zero length match,
			# which we don't want, so skip over it
			non_empty = false
			seps[nf] = substr(string, 1, 1)
			string = substr(string, 2)
		} else {
			# 0 length match
			if (! (nf in seps)) {
				if (RSTART == 1)
					seps[nf] = ""
				else
					seps[nf] = substr(string, 1, RSTART - 1)
			}
			array[++nf] = ""
			if (! non_empty && ! eosflag) { # prev was empty
				seps[nf] = substr(string, 1, 1)
			}
			if (RSTART == 1) {
				string = substr(string, 2)
			} else {
				string = substr(string, RSTART + 1)
			}
			non_empty = false
		}
		if (length(string) == 0) {
			if (eosflag)
				break
			else
				eosflag = true
		}
	}
	if (length(string) > 0)
		seps[nf] = string

	return length(array)
}
