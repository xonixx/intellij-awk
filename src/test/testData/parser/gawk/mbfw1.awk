# Date: Sun, 16 Mar 2008 18:51:14 +0100
# From: Hermann Peifer <peifer@gmx.eu>
# Subject: [Fwd: Gawk FIELDWIDTHS and multibyte characters]
# To: bug-gawk@gnu.org
# Message-id: <47DD5E12.2010403@gmx.eu>
# 
# See below. Regards, Hermann
# 
# --- Original Message ---
# 
# Newsgroups: comp.lang.awk
# From: Hermann Peifer <peifer@gmx.eu>
# Date: Sun, 16 Mar 2008 01:23:38 -0700 (PDT)
# Subject: Gawk FIELDWIDTHS and multibyte characters
# 
# Hi,
# 
# It looks to me that Gawk's FIELDWIDTHS extension is not aware of
# multibyte characters, see my example below.
# 
# $ cat testdata
# CDRegion              Commune             Site
# SEVästsverige         Hallands län        Kungsbacka
# SESmåland med öarna   Västra Götalands länGöteborg
# SEKronoberg           Alvesta             Stenungsund
# 
# $ file testdata
# testdata: UTF-8 Unicode text
# 
# $ awk 'BEGIN{FIELDWIDTHS = "2 20 20 20"}{print $4}' testdata
# Site
#    Kungsbacka
#   länGöteborg
# Stenungsund
# 
# Can someone confirm?
# 
# Hermann
BEGIN { FIELDWIDTHS = "2 20 20 20" }
{ print $4 }
