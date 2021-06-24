BEGIN {
	x = 537
	y = 3
	z = index(x, y)	# should print lint warning
	# now that STRCUR has been trigged on x and y, check that we still
	# get the warning
	z = index(x, y)	# should print lint warning
	if (z != 2)
		print "oops"
}
