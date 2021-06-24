BEGIN {
	x = "0"
	print x+0	# trigger NUMCUR
	IGNORECASE = x	# should enable ignorecase, since x is a non-null string
	y = "aBc"
	print (y ~ /abc/)
}
