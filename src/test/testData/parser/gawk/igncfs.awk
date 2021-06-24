BEGIN   {
        IGNORECASE=1
        FS="[^[:lower:]]+"
}
{
        for (i=1; i<NF; i++) printf "%s, ", $i
        printf "%s\n", $NF
}
