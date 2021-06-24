# Date: Sat, 02 Aug 2014 12:27:00 -0400
# To: bug-gawk@gnu.org
# From: Katherine Wasserman <katie@wass.net>
# Message-ID: <E1XDc9F-0007BX-O1@eggs.gnu.org>
# Subject: [bug-gawk] GAWK 4.1 SQRT() bug
# 
# In version 4.1.60 of GAWK the sqrt() function does not work correctly on bignums.
# Here's a demo of the problem along with, a function that does work correctly.
# 
# Running this program (sqrt-bug.awk):
# --------------------------------------------------------------------

@load "intdiv"
BEGIN {
a=11111111111111111111111111111111111111111111111111111111111
print sqrt(a^2)
#print sq_root(a^2)

# ADR: Added for gawk-4.1-stable which doesn't have built-in intdiv() function
if (PROCINFO["version"] < "4.1.60")
  print sq_root2(a^2)
else
  print sq_root(a^2)
}


function sq_root(x, temp,r,z)
{  temp=substr(x,1,length(x)/2) + 0 # a good first guess
   z=0
   while (abs(z-temp)>1)
    { z=temp
      intdiv(x,temp,r)
      temp=r["quotient"] + temp
      intdiv(temp,2,r)
      temp=r["quotient"]
    }
   return temp
}

function sq_root2(x, temp,r,z)
{  temp=substr(x,1,length(x)/2) + 0 # a good first guess
   z=0
   while (abs(z-temp)>1)
    { z=temp
      awk_div(x,temp,r)
      temp=r["quotient"] + temp
      awk_div(temp,2,r)
      temp=r["quotient"]
    }
   return temp
}

function abs(x)
{ return (x<0 ? -x : x)
}
# 
# --------------------------------------------------------------------
# gawk -M -f sqrt-bug.awk
# 
# results in:
# 11111111111111111261130863809439559987542611609749437808640
# 11111111111111111111111111111111111111111111111111111111111
# 
# Thanks,
# Katie
# 

# div --- do integer division

function awk_div(numerator, denominator, result,    i, save_PREC)
{
	save_PREC = PREC
	PREC = 400	# good enough for this test

	split("", result)

	numerator = int(numerator)
	denominator = int(denominator)
	result["quotient"] = int(numerator / denominator)
	result["remainder"] = int(numerator % denominator)

	PREC = save_PREC
	return 0.0
}
