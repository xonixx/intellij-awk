BEGIN {
    switch ("hello") {
        case -1:
            print -1
        case /he/:
            print 2
            print 2<caret>
        default:
            print 4
            print 4
    }
}