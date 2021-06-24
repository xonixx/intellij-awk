BEGIN {
	a[1][1]=1;
	b[1][1]=11;
#	delete b[a[1]][1];
	f(b, a)
}

function f(arr, s) {
	delete arr[s[1]][1]
}
