BEGIN {
    switch ("hello") {
        case -1:<caret>
            print -1
        case /he/:
            print 2
            print 2
        default:
            print 4
            print 4
    }
}