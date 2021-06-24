BEGIN {
then = mktime("1959 12 15 7 00 00")
print strftime(PROCINFO["strftime"], then)
}
