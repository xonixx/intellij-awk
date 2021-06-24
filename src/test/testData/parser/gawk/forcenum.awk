BEGIN {
	# make some strnums
	nf = split("|5apple|NaN|-NaN|+NaN| 6|0x1az|011Q|027", f, "|")

	for (i = 1; i <= nf; i++) {
		# NaN values on some systems can come out with
		# a sign in front of them. So instead of using %g to
		# convert the strnum to a double, do it manually, and
		# then remove any leading sign so that the test will
		# work across systems.
		val = f[i] + 0
		val = val ""
		val = tolower(val)
		sub(/^[-+]/, "", val)
		printf "[%s] -> %s (type %s)\n", f[i], val, typeof(f[i])
	}
}
