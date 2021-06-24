BEGIN {
	x = "011"
	print x+0	# trigger NUMCUR
	print strtonum(x)
}
