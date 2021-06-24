# Test field values after reparsing
FNR == 1 { record1 = $0 }
{
	printf "[%s] [%s] [%s] [%s]\n", $1, $2, $3, $4
	$0 = record1
	printf "[%s] [%s] [%s] [%s]\n", $1, $2, $3, $4
}
