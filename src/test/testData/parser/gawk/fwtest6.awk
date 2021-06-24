# BEGIN { FIELDWIDTHS = "2 2 *" }
BEGIN { FIELDWIDTHS = "2 2 * " }
{ print NF, $1, $2, $3 }
END { FIELDWIDTHS = "2 * 2" }
