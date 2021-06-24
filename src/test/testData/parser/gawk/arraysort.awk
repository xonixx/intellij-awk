# From: j.eh@mchsi.com
# March and April 2010

BEGIN {
	print "--- test1 ---"
	a[1] = b[3] = 5
	a[2] = b[2] = "3D"
	a[3] = b[1] = 10
	asort(a)
	asort(b)
	for (i = 1; i <= 3; ++i)
		printf("  %2s  %-2s\n", (a[i] ""), (b[i] ""))

	delete a
	delete b
}

BEGIN {
	print "--- test2 ---"
	a[100] = a[1] = a["x"] = a["y"] = 1
	PROCINFO["sorted_in"] = "@ind_num_asc"
	for (i in a)
		print i, a[i]
	delete a
}

BEGIN {
	print "--- test3 ---"
	a[100] = a[1] = a["x"] = 1
	PROCINFO["sorted_in"] = "@ind_num_asc"
	for (i in a)
		print i, a[i]
	delete a
}

BEGIN {
	print "--- test4 ---"
	a[0] = a[100] = a[1] = a["x"] = 1
	PROCINFO["sorted_in"] = "@ind_num_asc"
	for (i in a)
		print i, a[i]
	delete a
}

BEGIN {
	print "--- test5 ---"
	a[""] = a["y"] = a[0] = 1
	PROCINFO["sorted_in"] = "@ind_num_asc"
	for (i in a)
		print i, a[i]
	delete a
}

BEGIN {
	print "--- test6 ---"
	a[2] = a[1] = a[4] = a["3 "] = 1
	PROCINFO["sorted_in"] = "@ind_num_asc"
	for (i in a)
		print "\""i"\""
	delete a
}


BEGIN {
        print "--- test7 ---"
	n = split(" 4 \n 3\n3D\nD3\n3\n0\n2\n4\n1\n5", a, "\n")
	for (i = 1; i <= n; i++)
		b[a[i]] = a[i]
	print "--unsorted--"
	PROCINFO["sorted_in"] = "@unsorted"
	for (i in b)
		print "|"i"|"b[i]"|"

	print "--asc ind str--"
	PROCINFO["sorted_in"] = "@ind_str_asc"
	for (i in b)
		print "|"i"|"b[i]"|"
	print "--asc val str--"
	PROCINFO["sorted_in"] = "@val_str_asc"
	for (i in b)
		print "|"i"|"b[i]"|"
	print "--asc ind num--"
	PROCINFO["sorted_in"] = "@ind_num_asc"
	for (i in b)
		print "|"i"|"b[i]"|"
	print "--asc val num--"
	PROCINFO["sorted_in"] = "@val_num_asc"
	for (i in b)
		print "|"i"|"b[i]"|"
}
