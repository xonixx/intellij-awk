BEGIN {
    switch(1) {
        case 1: case 2:
        print 111 ; break
        case 6:
        case 7:
        default: print 222 }
}