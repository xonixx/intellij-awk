@load "readfile"
BEGIN { PROCINFO["readfile"] = 1 }
BEGINFILE { print "Start of", basename(FILENAME) }
{ printf ("%d: <%s>\n", FNR, $0 ) }
ENDFILE { print "End of", basename(FILENAME) }

function basename(file,		result)
{
	result = file
	gsub(".*/", "", result)
	return result
}
