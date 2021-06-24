BEGIN { RS = @/./ }
{ printf("<%s> <<%s>>\n", $0, RT) }
