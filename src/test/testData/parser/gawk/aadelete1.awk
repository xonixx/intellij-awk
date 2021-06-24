BEGIN {
	a[1][1] = 11
	a[1][2] = 12
	a[2] = 2
	delete a[1][1]
	f(a, a[1])
	print a[1][1]
	print length(a), length(a[1])
	delete a
	print length(a), length(a[1]), length(a)
	a[1][1] = 11
}

function f(c, b) {
	delete b
	b[1] = 1
	print c[1][1], b[1]
	delete c[2]
}
