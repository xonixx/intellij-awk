BEGIN {
	while (1) {
		if ((getline l1 < "/dev/fd/4") <= 0)
			break
		print l1

		if ((getline l2 < "/dev/fd/5") <= 0)
			break
		print l2
	}
}
