BEGIN {
	print gensub("x","y",2,"xx")
	print gensub("x","y","2","xx")
	print gensub("x","y","a","xx")
}
