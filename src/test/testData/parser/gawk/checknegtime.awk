NR == 1 {
	# Tue Dec 15 07:00:00 GMT 1959
	Weekday = $1
	Month = $2
	Day = $3
	Time = $4
	Timezone = $5
	Year = $6
}

NR == 2 {
	if (NF == 0)	# MinGW gives an empty line
		exit 0

	# Some BSDs give us UTC in the timezone
	if ($1 == Weekday && $2 == Month && $3 == Day &&
	    $4 == Time && $6 == Year)
		exit 0

	# Some other mismatch
	exit 1
}
