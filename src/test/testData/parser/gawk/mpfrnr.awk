# Test NR and FNR for file(s) with records > LONG_MAX
BEGIN {
	NR = 0x7FFFFFFF
}
BEGINFILE {
	FNR = 0x7fffffffffffffff
}
END {
	print NR, NR-0x7FFFFFFF, FNR, FNR-0x7fffffffffffffff
}
