BEGINFILE {
	print "In BEGINFILE:"
	filename = FILENAME
	gsub(/.*[/]/, "", filename)
	printf "\tFILENAME = %s, FNR = %d, ERRNO = \"%s\"\n", filename, FNR, ERRNO

	if (ERRNO != "")
		nextfile
}

FNR == 1 {	print "processing", filename }
FNR > 1	{ nextfile }

ENDFILE {
	print "In ENDFILE:"
	filename = FILENAME
	gsub(/.*[/]/, "", filename)
	printf "\tFILENAME = %s, FNR = %d, ERRNO = \"%s\"\n", filename, FNR, ERRNO
}
