BEGIN {
	x = 5^4^3^2
	print "# of digits =", length(x)
	print substr(x, 1, 20), "...", substr(x, length(x) - 19, 20)

	PREC = 1 + 3.321928095 * length(x);	# 1 + digits * log2(10)
	print "floating-point computation with precision =", PREC
	y = 5.0^4.0^3.0^2.0
	print "# of digits =", length(y)
	print substr(y, 1, 20), "...", substr(y, length(y) - 19, 20)
}
