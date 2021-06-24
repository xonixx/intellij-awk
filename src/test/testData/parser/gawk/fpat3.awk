BEGIN {
	FPAT = "[^,]*"

}

{
	if (x) NF
	for (i = 1; i <= 4; ++i)
		print i, $i
}
