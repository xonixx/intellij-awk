BEGIN {
	if (!SRCDIR) SRCDIR = "."
	OFS = ", "
	x = 4
	ret = (getline x < SRCDIR)
	print x, ret, ERRNO
}
