# numeric before string, ascending by index
function comp_num_str(s1, v1, s2, v2,		n1, n2) {
	n1 = s1 + 0
	n2 = s2 + 0
	if (n1 == s1)
		return (n2 == s2) ? (n1 - n2) : -1
	else if (n2 == s2)
		return 1
	return (s1 < s2) ? -1 : (s1 != s2)
}

# ascending index number
function comp_idx_num(s1, v1, s2, v2)
{
	return (s1 - s2)
}

# ascending value number
function comp_val_num(s1, v1, s2, v2,	num)
{
	num = "^[-+]?([0-9]+[.]?[0-9]*|[.][0-9]+)([eE][-+]?[0-9]+)?$"
	# force stable sort, compare as strings if not numeric
	if ((v1 - v2) == 0 && (v1 !~ num || v2 !~ num))
		return comp_val_str(s1, v1, s2, v2)
	return (v1 - v2)
}

# ascending value string
function comp_val_str(s1, v1, s2, v2)
{
	v1 = v1 ""
	v2 = v2 ""
	return (v1 < v2) ? -1 : (v1 != v2)
}

# deterministic, by value (and index), descending numeric
function comp_val_idx(s1, v1, s2, v2)
{
	return (v1 != v2) ? (v2 - v1) : (s2 - s1)
}

BEGIN {
	a[1] = 10; a[100] = 1; a[2] = 200
	a["cat"] = "tac"; a["rat"] = "tar";a["bat"] = "tab"

	print "--- number before string, ascending by index ---"
	PROCINFO["sorted_in"] = "comp_num_str"
	for (i in a)
		printf("%-10s%-s\n", i, a[i])

	delete a
	a[11] = 10; a[100] = 5; a[2] = 200
	a[4] = 1; a[20] = 10; a[14] = 10
	print "--- deterministic, by value (index), descending numeric ---"
	PROCINFO["sorted_in"] = "comp_val_idx"
	for (i in a)
		printf("%-10s%-s\n", i, a[i])

	for (IGNORECASE=0; IGNORECASE <= 1; IGNORECASE++) {
		makea(a)
		SORT_STR =  "comp_val_num"
		printf("--- asort(a, b, \"%s\"), IGNORECASE = %d---\n", SORT_STR, IGNORECASE)
		asort2(a, "")

		makea(a)
		SORT_STR =  "comp_val_str"
		printf("--- asort(a, b, \"%s\"), IGNORECASE = %d---\n", SORT_STR, IGNORECASE)
		asort2(a, "")

		makea(a)
		SORT_STR = "comp_val_str"
		printf("--- asort(a, a, \"%s\"), IGNORECASE = %d---\n", SORT_STR, IGNORECASE)
		asort1(a, "")
  }
}

function makea(aa)
{
	delete aa
	aa[1] = "barz";
	aa[2] = "blattt";
	aa[3] = "Zebra";
	aa[4] = 1234;
	aa[5] = 234;
}

# source array != destination array 
function asort2(c, s,	d, k, m) 
{
	if (SORT_STR < 0)
		m = asort(c, d);
	else
		m = asort(c, d, SORT_STR);
	for (k=1; k <= m; k++) {
		if (isarray(d[k]))
			asort2(d[k], s"["k"]")
		else
			printf("%-10s:%-10s%-10s\n", s"["k"]", c[k], d[k])
	}
}

# source array == destination array
function asort1(c, s,   k, m) 
{
	if (SORT_STR < 0)
		m = asort(c)
	else if (SORT_STR != "")
		m = asort(c, c, SORT_STR)
	else
		m = asort(c, c);

	for (k=1; k <= m; k++) {
		if (isarray(c[k]))
			asort1(c[k], s"["k"]")
		else
			printf("%-10s:%-10s\n", s"["k"]", c[k])
	}
}
