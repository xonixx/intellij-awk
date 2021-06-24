BEGIN {
  n = 2
  TEXTDOMAIN = "nlstringtest"
#  bindtextdomain ("./")
  bindtextdomain (ARGV[1])

  printf dcngettext ("a piece of cake", "%d pieces of cake", n) "\n", n

  print _"%s is replaced by %s."
  print _"%s is replaced by %s." "\n"
  printf _"%s is replaced by %s." "\n", "FF", "EUR"
}
