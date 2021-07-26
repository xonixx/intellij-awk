BEGIN {
	split("0|0a", f, "|")
	z = int(f[1])	# no warning, since strnum converted to number
	x = f[2]+0	# trigger NUMCUR
	z = int(f[2])	# should print a warning
	x = "0"
	y = x+0		# trigger NUMCUR
	z = int(x)	# should print a warning, since x is still a string!
}
