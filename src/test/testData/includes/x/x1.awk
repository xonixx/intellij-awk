
@include "x/x2.awk"
@include "y/y2"      # testing no ext
@include "d.awk"

@include "./x3.awk"  # testing rel
@include "../y/y3"   # testing rel, no ext
