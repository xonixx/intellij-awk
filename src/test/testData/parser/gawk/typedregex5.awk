BEGIN { FS = @/./ }
{ print typeof(FS), $1, NF }
