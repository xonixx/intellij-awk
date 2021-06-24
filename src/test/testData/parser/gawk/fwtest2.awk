# Date: Fri, 24 Mar 2006 15:17:24 +0100
# From: =?UTF-8?Q?Ram=C3=B3n_Garc=C3=ADa?= <ramon.garcia.f@gmail.com>
# Subject: Re: Bug when parsing FIELDWIDTHS
# In-reply-to: <200603241144.k2OBiFOX030158@skeeve.com>
# To: Aharon Robbins <arnold@skeeve.com>
# Message-id: <daa40b5d0603240617j1b7e8861g3963035eafdeba1e@mail.gmail.com>
# MIME-version: 1.0
# Content-type: multipart/mixed; boundary="----=_Part_9022_17179442.1143209844259"
# DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;        s=beta; d=gmail.com;
#  h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
#  b=QVst9uUwAllKuDwXhuHbNjpRJStt3nEGc7p+BMG+HNk/qyHmnG/TYXSvIVKgZFja1thLhYbPYncw2MyEHtKyZuiTJCYqvpjWeST9qQNfxVMeu8FahqAky7n8ldsjOK6ncbCoE3hZe/g/Z9ZsVFC9LORXvM5uo7y1MGkUhgxO4qU=
# 
# ------=_Part_9022_17179442.1143209844259
# Content-Type: text/plain; charset=UTF-8
# Content-Transfer-Encoding: base64
# Content-Disposition: inline
# 
# DQpTdXJlLiBIZXJlIGl0IGlzLg0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
# IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQpUaGlz
# IE1haWwgV2FzIFNjYW5uZWQgYnkgMDEyLm5ldCBBbnRpVmlydXMgU2VydmljZTItIFBvd2VyZWQg
# YnkgVHJlbmRNaWNybyBJbnRlcnNjYW4NCg==
# ------=_Part_9022_17179442.1143209844259
# Content-Type: application/octet-stream; name=bug_data
# Content-Transfer-Encoding: 7bit
# X-Attachment-Id: f_el6ll617
# Content-Disposition: attachment; filename="bug_data"
# 
#    0.4867373206   1.3206333033  -0.2333178127 
#    0.5668176165   1.3711756314  -0.2193558040 
#    0.4325251781   1.3399488722  -0.1568307497 
#    0.4900487563   1.3295759570  -0.2217392402 
#   -0.6790064191   1.2536623801  -0.2955415433 
#   -0.6311440220   1.2966579993  -0.2246692210 
#   -0.7209390351   1.1783407099  -0.2539408209 
#   -0.6782473356   1.2495242556  -0.2811436366 
#   -0.7062054082   1.1223820964  -1.1619805834 
#   -0.6491590119   1.1248946162  -1.0851579675 
#   -0.7948856821   1.1208852325  -1.1259821556 
#   -0.7102549262   1.1225121126  -1.1475381286         
# 
# ------=_Part_9022_17179442.1143209844259
# Content-Type: application/octet-stream; name=bug.awk
# Content-Transfer-Encoding: 7bit
# X-Attachment-Id: f_el6llnjj
# Content-Disposition: attachment; filename="bug.awk"
# 
#!/usr/bin/awk -f
BEGIN {
   FIELDWIDTHS = "15 15 15";
}
{
   x = $1;
   y = $2;
   z = $3;
   print "x y z", x, y, z
}
# 
# ------=_Part_9022_17179442.1143209844259--
# 
