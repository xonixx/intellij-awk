# Date: Mon, 28 Jul 2008 17:25:32 +0200
# From: Dirk Zimoch <dirk.zimoch@psi.ch>
# Subject: match() prevents numeric strings from beeing treated numerically
# To: bug-gawk@gnu.org
# Message-id: <488DE4EC.6020400@psi.ch>
# 
# In gawk version 3.1.5, numeric user input that is parsed with match() is not 
# recognized as "numeric string" any more. I.e. mixed string-numeric comparison 
# does not work any more. In version 3.1.1, it worked. (Even though the 
# documentation never explicitly mentioned this behavior for match(), as it does 
# for split(). But is says that "user input" should be treated that way.)
# 
# awk 'BEGIN{match(".5",/.*/,a);print a[0]==.5?"OK":"FAULT"}'
# 
# Version 3.1.1 prints OK, version 3.1.5 prints FAULT.
# 
# awk '{match($0,/.*/,a);print a[0]==a[0]+0?"OK":"FAULT"}' << EOF
# 5
# 5.0
# 0.5
# .5
# EOF
# 
# Version 3.1.1 prints
# OK
# OK
# OK
# OK
# 
# Version 3.1.5 prints
# OK
# FAULT
# OK
# FAULT
# 
# 
# -- 
# Dr. Dirk Zimoch
# Paul Scherrer Institut, WBGB/006
# 5232 Villigen PSI, Switzerland
# Phone +41 56 310 5182
# 
{
	match($0,/.*/,a)
	print a[0] == a[0]+0 ? "OK" : "FAULT"
}
