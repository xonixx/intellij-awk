{ a[$0]++ }
END {
	PROCINFO["sorted_in"] = "@ind_str_asc"
	for (i in a)
		print i
	PROCINFO["sorted_in"] = "@ind_str_desc"
	for (i in a)
		print i
}
