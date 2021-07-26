BEGIN {
   FIELDWIDTHS = "2:13 2:13 2:13";
}
{
   printf "%s|%s|%s\n", $1, $2, $3
}
