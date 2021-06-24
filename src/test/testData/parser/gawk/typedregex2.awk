BEGIN {
        x = @/xxx/
        y = @/yyy/
        print typeof(x), typeof(y)
        print x, y

        x++
        y = y ""
        print typeof(x), typeof(y)
        print x, y
}
