
@include "x/x2.awk"
@include "y/y2"      # testing no ext
@include "d.awk"

# XXX in fact this is way more permissive, but hope this doesn't cause too much false-positives
@include "./x3.awk"  # testing rel
@include "../y/y3"   # testing rel, no ext

BEGIN { print "x1.awk" }