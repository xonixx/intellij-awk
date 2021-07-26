# This test case adds some numbers and the answer is 42.
# It was written to honour the scientists who solved a longstanding
# problem that was made popular by Douglas Adams in his book
# The Hitchhiker's Guide to the Galaxy.
# https://en.wikipedia.org/wiki/42_(number)#The_Hitchhiker's_Guide_to_the_Galaxy
# In September 2019, the University of Bristol made a release
# about the solution they found:
# https://www.bristol.ac.uk/news/2019/september/sum-of-three-cubes-.html
#
# This test case uses GAWK's big numbers to reproduce the calculation.

BEGIN {
  x = -80538738812075974
  y = 80435758145817515
  z = 12602123297335631
  print x^3 + y^3 + z^3
}

