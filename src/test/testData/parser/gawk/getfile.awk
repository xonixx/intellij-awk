function basename(x) {
	return gensub(/^.*\//, "", 1, x)
}

BEGIN {
	print "BEGIN"

	cmd = "echo hello; echo goodbye"
	rc = get_file(cmd, "<<", -1, res)
	print "expected error result", rc, ERRNO
	print "get_file returned", get_file(cmd, "|<", -1, res)
	print "input_name", basename(res["input_name"])
	print (cmd | getline x)
	print x

	# check that calling get_file on "" triggers the BEGINFILE rule
	print "get_file returned", get_file("", "", -1, res)
	print "input_name", basename(res["input_name"])
	print "end BEGIN"
}

BEGINFILE {
	printf "BEGINFILE (%s) ERRNO (%s)\n", basename(FILENAME), ERRNO
}

ENDFILE {
	printf "ENDFILE (%s) ERRNO (%s)\n", basename(FILENAME), ERRNO
}

END {
	print "END"
	print (cmd | getline x)
	print x
	print close(cmd)
}
