BEGIN { FPAT = "\"[^\"]*\"" }

{ print $1 }

END { f("hi there") }

function f (p,   a, n, i)
{
        n = split(p,a)
        print n ; for (i=1; i<=n; i++) print a[i]
}
