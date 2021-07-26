BEGIN {			# Comment 0
	if (1) {	# Comment 1
		print "ABC"	# Comment2
	} else {	# Comment 3
		print "XYZ"	# Comment 4
	}			# Comment 5

	while (c == d) {	# Comment 6
		print "DEF"	# Comment 7
	}			# Comment 8

	do {			# Comment 9
		print "GHI"	# Comment 10
	} while (e == f)	# Comment 11

	for (i in data) {	# Comment 12
		print "JKL"	# Comment 13
	}			# Comment 14

	for (z = 1; z <= 10; z++) {	# Comment 15
		print "MNO"		# Comment 16
	}				# Comment 17

	switch (q) {	# Comment 18
	case "a":	# Comment 19
	case "b":
		# Comment 20
		break	# Comment 21
	default:	# Comment 22
		break	# Comment 23
	}		# Comment 24

	if (1) {
		print "foo"
	}		# Comment 25

	if (2) {
		print "bar"
	}
	# Comment 26
}
# Comment 27
