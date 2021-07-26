# Message-ID: <1312419482.36133.YahooMailNeo@web110416.mail.gq1.yahoo.com>
# Date: Wed, 3 Aug 2011 17:58:02 -0700 (PDT)
# From: "T. X. G." <leopardie333@yahoo.com>
# To: "bug-gawk@gnu.org" <bug-gawk@gnu.org>
# Subject: [bug-gawk] two bugs in gawk 4.0.0 with FPAT and pty
# 
# $ gawk --version
# GNU Awk 4.0.0
# Copyright (C) 1989, 1991-2011 Free Software Foundation.
# 
# # bug due to trying to make field splitting more efficient by not parse all fields 
# $ echo a,b,,c |gawk '{for(i=1;i<=4;++i)print i, $i}' FPAT='[^,]*'
# 1 a
# 2 
# 3 b
# 4 
# 
# # work around
# $ echo a,b,,c |gawk '{NF;for(i=1;i<=4;++i)print i, $i}' FPAT='[^,]*'
# 1 a
# 2 b
# 3 
# 4 c
# 
# This bug, as you commented in function fpat_parse_field, is subtle. The null matches of previous call should be remembered across calls. You could make the auto variable non_empty static, but then any calls to patsplit between references of fields will cause it to be wrong. I guess you can either forgo the field splitting optimization by always parse all field in the case of FPAT or make a separate function for splitting $0 only (or pass an extra arg to it?) I am sure you will find the best fix.
# 
# 
# The next bug is with pty:
# 
# $ gawk 'BEGIN{
# c = "echo 123 > /dev/tty; read x < /dev/tty; echo \"x is $x\""
# PROCINFO[c, "pty"] = 1
# c |& getline;print
# print "abc" |& c
# c |& getline;print
# }'
# 123
# ^C
# 
# Adding a call to setsid() in the function two_way_open right after fork in the child process seems to fix it.
# 
# One request for feature:
# Currently the format for mktime is not configurable. Could you please make it configurable just like strftime through PROCINFO["mktime"]? In fact I have already done it myself. But I don't think you would like my style. It should be pretty simple for you to implement.
# 
# Thank you, Arnold. Again as I have said before, I enjoy your writings and appreciate your contributions to the FSF. 
# W. G.
# 
BEGIN	{
	c = "echo 123 > /dev/tty; read x < /dev/tty; echo \"x is $x\""
	PROCINFO[c, "pty"] = 1
	c |& getline; print
	print "abc" |& c
	c |& getline; print
}
