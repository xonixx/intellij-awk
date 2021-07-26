# lintold.awk --- test --lint-old

BEGIN {
	a[1] = 1
	for (i in a)
	  print a[i]
	delete a[1]
	if (2 in a)
	  a[2] **= 2;
	if ((2,3) in a)
	  a[2,3] ^= 2 ** 3 ^ 4;
}
BEGIN {
	FS = "ab"
	foo = "\b\f\r"
}
END {
}
END {
        print "done"
}
