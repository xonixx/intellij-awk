BEGIN {
	a[1][1] = 10;
	a[1][2] = 20;
	a[1][3] = 30;
	a[2] = "hello world! we have multi-dimensional array"
	a[3, "X"] = "Y"
	print length(a), length(a[1])
	delete a[2]
	delete a[3, "X"] 
	a[2][1] = 100;
	a[2][2] = 200;
	a[2][3] = 300;
	for (i in a) {
		sum[i] = 0
		for (j in a[i])
			sum[i] += a[i][j]
	}
	print sum[1], sum[2]
	f(a[1])
	print a[1][1]
}

function f(x,   i)
{
	for (i=1;i<=length(x);i++)
		print x[i]
	x[1] = 1001
}
