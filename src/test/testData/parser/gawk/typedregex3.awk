BEGIN {
	a[1] = @/abc/
	b[1][2][3] = @/xyz/
	print typeof(a[1]), typeof(b[1][2][3])
	print a[1], b[1][2][3]

	a[1]++
	b[1][2][3] ""
	print typeof(a[1]), typeof(b[1][2][3])
	print a[1], b[1][2][3]
}
