BEGIN{ a["x"]["y"]["z"]="scalar" ; walk_array(a, "a")}
function walk_array(arr, name, i,	r)
{
	for (i in arr) {
		r = typeof(arr[i])
#		printf("typeof(%s[%s]) = %s\n", name, i, r) > "/dev/stderr"
		if (r == "array") {
			walk_array(arr[i], name "[" i "]")
		} else {
			printf "%s[%s] = %s\n", name, i, arr[i]
		}
	}
}
