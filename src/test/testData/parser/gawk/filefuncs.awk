@load "filefuncs"

BEGIN {
   if (chdir(builddir) < 0) {
      printf "Error: chdir failed with ERRNO %s\n", ERRNO
      exit 1
   }

   if (stat(ARGV[0] "api.o", st) < 0) {
      printf "Error: stat(%s) failed with ERRNO %s\n", ARGV[0] "api.o", ERRNO
      exit 1
   }

   nf = split("name dev ino mode nlink uid gid size blocks atime mtime ctime pmode type", f)

   for (i = 1; i <= nf; i++) {
      if (!(f[i] in st)) {
	 printf "stat value for %s is missing\n",f[i]
	 rc = 1
      }
      else
	 delete st[f[i]]
   }
   exit rc+0
}
