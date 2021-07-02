BEGIN {
    switch ("hello") {
        case -1:
            print -1
        case /he/:
            if (1)
                print 1
            else
                print 2
        case @/he/:
        case @/asd/:
            if (1) {
                print 1
            }
        default:
            print 4
            print 4
    }
}