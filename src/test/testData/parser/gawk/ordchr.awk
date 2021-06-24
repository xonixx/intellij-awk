@load "ordchr"

BEGIN {
   print chr(ord("A"))
   print chr(ord("0"))
   print ord(chr(65))
   # test if type conversion between strings and numbers is working properly
   print chr(ord(0))
   print ord(chr("65"))
}
