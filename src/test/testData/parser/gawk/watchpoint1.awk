#! /usr/bin/gawk -f
BEGIN {
     c = 0
}

/apple/ {
     nr = NR
     c++
     # printf "[c, NR] = [%s, %s]\n", c, NR
}

END {
    print c
}
