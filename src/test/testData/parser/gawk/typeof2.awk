BEGIN {
	print typeof(x)
	x[1] = 3
	print typeof(x)
}

function test1() {
}

function test2(p) {
	p[1] = 1
}

BEGIN {
	print typeof(a)
	test1(a)
	print typeof(a)
	test2(a)
	print typeof(a)
}
