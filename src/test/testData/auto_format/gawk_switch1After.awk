BEGIN {
    switch ("hello") {
        case -1:
            print -1
        case /he/:
            print 2
            print 2
        case @/he/:
        case @/asd/:
            print 3
        default:
            print 4
            print 4
    }
}