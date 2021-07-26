BEGIN {
#	if (t == 0)
		FPAT = "([^,]+)|(\"[^\"]+\")"
#	else
#		FPAT = "([^,]*)|(\"[^\"]+\")"
}
FNR == 1 {
	# This part was added later
	print $1
	print $1, $3
	for (i = 1; i <= NF; i++)
		print i, $i

	# Reset for original part of test
	FPAT = "([^,]*)|(\"[^\"]+\")"
	$0 = $0
}
{
	print "NF =", NF
	for (i = 1; i <= NF; i++)
		printf("$%d = <%s>\n", i, $i)
}
