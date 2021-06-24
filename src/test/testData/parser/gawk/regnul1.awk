# From denis@gissoft.eu Thu May 29 09:07:56 IDT 2014
# Article: 8400 of comp.lang.awk
# X-Received: by 10.236.81.99 with SMTP id l63mr3912466yhe.3.1401224812642;
#         Tue, 27 May 2014 14:06:52 -0700 (PDT)
# X-Received: by 10.140.37.148 with SMTP id r20mr578874qgr.0.1401224812310; Tue,
#  27 May 2014 14:06:52 -0700 (PDT)
# Path: eternal-september.org!news.eternal-september.org!feeder.eternal-september.org!v102.xanadu-bbs.net!xanadu-bbs.net!news.glorb.com!hl10no6493021igb.0!news-out.google.com!gi6ni15574igc.0!nntp.google.com!hl10no6493018igb.0!postnews.google.com!glegroupsg2000goo.googlegroups.com!not-for-mail
# Newsgroups: comp.lang.awk
# Date: Tue, 27 May 2014 14:06:52 -0700 (PDT)
# Complaints-To: groups-abuse@google.com
# Injection-Info: glegroupsg2000goo.googlegroups.com; posting-host=85.253.50.165;
#  posting-account=zNhVLgoAAACsg-WfVe_or2VV7loUhx8H
# NNTP-Posting-Host: 85.253.50.165
# User-Agent: G2/1.0
# MIME-Version: 1.0
# Message-ID: <3112e356-d2e1-45cd-ba55-2f939ee50105@googlegroups.com>
# Subject: \0 character can't be implement inside regexp in some cases?
# From: denis@gissoft.eu
# Injection-Date: Tue, 27 May 2014 21:06:52 +0000
# Content-Type: text/plain; charset=ISO-8859-1
# Xref: news.eternal-september.org comp.lang.awk:8400
# 
# Hello,
# 
# while doing some experiments with the gawk(4.1.1) i was found problem in implementing character \x00 inside regexp for two cases:
# 
# str~/\0/
# 
# and
# 
# switch ( str ) { case /\0/: ... }
# 
# the following code try to match given string(=="\x00") with the regexp /^\0$/ using different ways provided by gawk:
# 
func	_chm(t) {
	_ch("match()",match(t,/^\0$/))
	_ch("split()",split(t,A,/^\0$/)>1)
	_ch("patsplit()",patsplit(t,A,/^\0$/))
	_ch("gsub()",gsub(/^\0$/,"&",t))
	_ch("sub()",sub(/^\0$/,"&",t))
	_ch("gensub()",!gensub(/^\0$/,"","G",t))
	_ch("str~/rexp/",t~/^\0$/)
	a=0; switch ( t ) { case /^\0$/: a=1 }; _ch("switch-case //",a) }

func	_ch(fn,bool) {
	print substr(fn ":                ",1,16) (bool ? "+" : "-") }

BEGIN{ _chm("\000") }
# 
# output:
# 
# > gawk -f _null.gwk
# match():        +
# split():        +
# patsplit():     +
# gsub():         +
# sub():          +
# gensub():       +
# str~/rexp/:     -
# switch-case //: -
# 
# can someone explain me:
# 
# why in case using match(), split(), patsplit(), gsub(), sub() and gensub() the given string "\x00" matches with the /^\0$/
# 
# but in cases:
# 
# "\x00"~/^\0$/
# 
# and
# 
# switch ( "\x00" ) { case /^\0$/: doesn't match? }
# 
# 
# thank You
# 
# 
# GNU Awk 4.1.1, API: 1.1 (GNU MPFR 3.1.0-p8, GNU MP 5.0.2)
# Copyright (C) 1989, 1991-2014 Free Software Foundation.
# downloaded from ezwinports
# 
# windows 7x64; cmd
# 
# 
