BEGIN {
    switch ("hello") {
        case -1:
            print -1
        case /he/:<caret>
            print 2
            print 2
        default:
            print 4
            print 4
    }
}