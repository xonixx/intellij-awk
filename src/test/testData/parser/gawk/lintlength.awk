BEGIN {
	x = 5
	z =  length(x)	# should issue a warning
	y = (x "")	# trigger STRCUR
	z = length(x)	# should still issue a warning
}
