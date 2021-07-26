BEGIN { FPAT = "[^,]*" }
{ print $1, $2 }
