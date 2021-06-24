BEGIN {
	FPAT = "([^,]*)|(\"[^\"]+\")"
	OFS = ";"
}

p != 0 { print NF }

{ $1 = $1 ; print }
