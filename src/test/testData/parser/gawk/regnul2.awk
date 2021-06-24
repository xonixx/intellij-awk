# From denis@gissoft.eu Thu May 29 09:10:18 IDT 2014
# Article: 8408 of comp.lang.awk
# X-Received: by 10.182.128.166 with SMTP id np6mr93689obb.16.1401289466734;
#         Wed, 28 May 2014 08:04:26 -0700 (PDT)
# X-Received: by 10.140.36.6 with SMTP id o6mr4939qgo.26.1401289466607; Wed, 28
#  May 2014 08:04:26 -0700 (PDT)
# Path: eternal-september.org!news.eternal-september.org!feeder.eternal-september.org!news.glorb.com!c1no19185457igq.0!news-out.google.com!qf4ni13600igc.0!nntp.google.com!c1no19185454igq.0!postnews.google.com!glegroupsg2000goo.googlegroups.com!not-for-mail
# Newsgroups: comp.lang.awk
# Date: Wed, 28 May 2014 08:04:26 -0700 (PDT)
# In-Reply-To: <lm4rra$4u9$1@dont-email.me>
# Complaints-To: groups-abuse@google.com
# Injection-Info: glegroupsg2000goo.googlegroups.com; posting-host=82.131.35.51; posting-account=zNhVLgoAAACsg-WfVe_or2VV7loUhx8H
# NNTP-Posting-Host: 82.131.35.51
# References: <3112e356-d2e1-45cd-ba55-2f939ee50105@googlegroups.com>
#  <lm34d7$tb4$1@news.m-online.net> <f666871f-a94c-4505-9677-8711d656433c@googlegroups.com>
#  <lm4rra$4u9$1@dont-email.me>
# User-Agent: G2/1.0
# MIME-Version: 1.0
# Message-ID: <79828a24-d265-4e88-8de1-e61ecbaa6701@googlegroups.com>
# Subject: Re: \0 character can't be implement inside regexp in some cases?
# From: Denis Shirokov <denis@gissoft.eu>
# Injection-Date: Wed, 28 May 2014 15:04:26 +0000
# Content-Type: text/plain; charset=ISO-8859-1
# Xref: news.eternal-september.org comp.lang.awk:8408
# 
# 
#  All of the other use-cases just cluttered up your posting. 
# 
# oh, really?
# 
# 1. where in the Janis code the case with the `switch-case'?
# 2. how do you know about that there is only two cases? may be you know it because my code contains the other test cases?
# 3. fine. do you know what situation with the dynamic regexps? no?
# 4. do you know what situation with RS,FS and /.../ in the middle-area? how you can say that there is only two cases if you absolutely do not know it?
# 
# i'm asking: WHO will perform testing other cases? You? gawk-team? the God?
# what is that point of view: that it will be enough to say:
# Oh! my match(t,/^\0$/) is matching "\x00" but t~/^\0$/ is not. why oh why?
# 
# where is the test cover? or you think that other peoples will doing its instead of You? instead of Me?
# 
# and the second point: guys you are screaming about two levels of stack. really,  you kidding? =)
# 
# however, i'm attaching some additional information about dynrexp:
# 
func	_chmd(t,r) {
	_ch("match()",match(t,r))
	_ch("split()",split(t,A,r)>1)
	_ch("patsplit()",patsplit(t,A,r))
	_ch("gsub()",gsub(r,"&",t))
	t2=t; _ch("sub()",sub(r,"&",t2))
	_ch("gensub()",!gensub(r,"","G",t))
	_ch("str~/rexp/",t~r)
	# switch-case is not applicable with dynrxp
	_conline() }

func	_ch(fn,bool) {
	print substr(fn ":                ",1,16) (bool ? "+" : "-") }

func	_conline() {
	print "__________________________"; print }

BEGIN{ _chmd("\x01","^\1$")     #testing that all doings right; all match
	_chmd("\x00","^\1$")      #testing that all doings right; all not match
	_chmd("\x00","^\0$")      #tesing dynrexp
}
# 
# output:
# 
# match():        +
# split():        +
# patsplit():     +
# gsub():         +
# sub():          +
# gensub():       +
# str~/rexp/:     +
# __________________________
# 
# match():        -
# split():        -
# patsplit():     -
# gsub():         -
# sub():          -
# gensub():       -
# str~/rexp/:     -
# __________________________
# 
# match():        +
# split():        +
# patsplit():     +
# gsub():         +
# sub():          +
# gensub():       +
# str~/rexp/:     -
# 
# it's looks like with the dynamic regexp the same story.
# 
# i found another one moment that is possible near with the reason of this issue:
# 
# i was testing what characters can be present in doublestring and regexp "directly" (just as the character) and what characters must be present as escape sequence (\qqq)
# 
# so, i found the following:
# 
# t="abc"
# if ( match(t,/^abc[NUL]def/) ) ... - where [NUL] is the character \x00 
# 
# it's seems that in that case the regular expression is processed until [NUL]character and the other part is ignored because the example above gives TRUE
# 
# friendship
# Denis Shirokov
# 
# 
