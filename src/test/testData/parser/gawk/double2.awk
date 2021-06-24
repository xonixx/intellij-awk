# Date: Mon, 19 Dec 2005 18:14:13 -0800
# From: David Ellsworth <ellswort@nas.nasa.gov>
# Subject: Re: gawk number to string bug
# To: eggert@CS.UCLA.EDU, eliz@gnu.org
# Cc: arnold@skeeve.com, aschorr@telemetry-investments.com,
#         bug-gnu-utils@gnu.org, ellswort@nas.nasa.gov
# Message-id: <200512200214.jBK2EDuu020216@ece03.nas.nasa.gov>
# 
# Since you are taking my bug report seriously (which is really great),
# let me add some more fuel to the fire.  Consider this program:
# 
# BEGIN { x=2**60; for(i=60;i<=65;i++) { printf "2^%d= %s %d %g\n",i,x,x,x; x*=2}}
# 
# which prints out powers of two around 2^63.  On an Opteron (as well as
# an Itanium), you get
# 
# 2^60= 1152921504606846976 1152921504606846976 1.15292e+18
# 2^61= 2305843009213693952 2305843009213693952 2.30584e+18
# 2^62= 4611686018427387904 4611686018427387904 4.61169e+18
# 2^63= -9223372036854775808 9223372036854775808 9.22337e+18
# 2^64= 1.84467e+19 0 1.84467e+19
# 2^65= 3.68935e+19 3.68935e+19 3.68935e+19
# 
# On a Xeon, you get
# 
# 2^60= 1.15292e+18 1152921504606846976 1.15292e+18
# 2^61= 2.30584e+18 2305843009213693952 2.30584e+18
# 2^62= 4.61169e+18 4611686018427387904 4.61169e+18
# 2^63= 9.22337e+18 9223372036854775808 9.22337e+18
# 2^64= 1.84467e+19 0 1.84467e+19
# 2^65= 3.68935e+19 3.68935e+19 3.68935e+19
# 
# The 2^64 value for %d is probably also a bug since the outputs
# for 2^63 and 2^65 are reasonable.
# 
# - David
# 

BEGIN {
	x = 2 ^ 60
#	for (i = 60; i <= 65; i++) {
	for (i = 60; i <= 63; i++) {
		printf "2^%d= %s %d %g %o\n", i, x, x, x, x
		x *= 2
	}
}
