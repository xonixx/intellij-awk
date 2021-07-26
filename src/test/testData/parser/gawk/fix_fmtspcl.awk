BEGIN {
	pnan = sprintf("%g",sqrt(-1))
	nnan = sprintf("%g",-sqrt(-1))
	pinf = sprintf("%g",-log(0))
	ninf = sprintf("%g",log(0))

	pnanu = toupper(pnan)
	nnanu = toupper(nnan)
	pinfu = toupper(pinf)
	ninfu = toupper(ninf)
}
{
	sub(/positive_nan/, pnan)
	sub(/negative_nan/, nnan)
	sub(/positive_infinity/, pinf)
	sub(/negative_infinity/, ninf)
	sub(/POSITIVE_NAN/, pnanu)
	sub(/NEGATIVE_NAN/, nnanu)
	sub(/POSITIVE_INFINITY/, pinfu)
	sub(/NEGATIVE_INFINITY/, ninfu)
	sub(/fmtspcl/,(sd "/fmtspcl"))
	print
}
