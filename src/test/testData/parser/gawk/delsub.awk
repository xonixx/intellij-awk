function f(c, d, x) { delete c; x = d[0] }
BEGIN { a[0][0] = 1; f(a, a[0]); print "still here" }
