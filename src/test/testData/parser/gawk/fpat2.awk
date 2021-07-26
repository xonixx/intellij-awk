BEGIN {
	FPAT = " "
	$0 = ""
	print NF

	$0 = "abc"
	print NF

	$0 = "a b c"
	print NF
}
