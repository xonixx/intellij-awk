BEGIN {
#	s = "1.0 +nan 0.0 -1 +inf -0.0 1 nan 1.0 -nan -inf 2.0"
	s = "1.0 +nan 0.0 -1 +inf -0.0 1 1.0 -nan -inf 2.0"
	split(s, a)
	PROCINFO["sorted_in"] = "@val_num_asc"
	for (i in a)
		print a[i]
}
