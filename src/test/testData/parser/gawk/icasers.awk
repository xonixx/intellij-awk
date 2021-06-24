BEGIN { RS = "[[:upper:]\\n]+" }
{ print ; IGNORECASE = ! IGNORECASE }
