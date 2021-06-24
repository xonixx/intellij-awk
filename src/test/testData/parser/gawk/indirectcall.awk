# funcptrdemo.awk --- Demonstrate function pointers
#
# Arnold Robbins, arnold@skeeve.com, Public Domain
# January 2009

# average --- return the average of the values in fields $first - $last

function average(first, last,	sum, i)
{
	sum = 0;
	for (i = first; i <= last; i++)
		sum += $i

	return sum / (last - first + 1)
}

# sum --- return the average of the values in fields $first - $last

function sum(first, last,	ret, i)
{
	ret = 0;
	for (i = first; i <= last; i++)
		ret += $i

	return ret
}

# For each record, print the class name and the requested statistics

{
	class_name = $1
	gsub(/_/, " ", class_name)	# Replace _ with spaces

	# find start
	for (i = 1; i <= NF; i++) {
		if ($i == "data:") {
			start = i + 1
			break
		}
	}

	printf("%s:\n", class_name)
	for (i = 2; $i != "data:"; i++) {
		the_function = $i
		printf("\t%s: <%s>\n", $i, @the_function(start, NF) "")
	}
	print ""
}

# do_sort --- sort the data in ascending order and print it

function do_sort(first, last, compare,		data, i, retval)
{
	delete data
	for (i = 1; first <= last; first++) {
		data[i] = $first
		i++
	}

	quicksort(data, 1, i-1, compare)

	retval = data[1]
	for (i = 2; i in data; i++)
		retval = retval " " data[i]
	
	return retval
}

# sort --- sort the data in ascending order and print it

function sort(first, last)
{
	return do_sort(first, last, "num_lt")
}

# rsort --- sort the data in descending order and print it

function rsort(first, last)
{
	return do_sort(first, last, "num_ge")
}

# num_lt --- do a numeric less than comparison

function num_lt(left, right)
{
	return ((left + 0) < (right + 0))
}

# num_ge --- do a numeric greater than or equal to comparison

function num_ge(left, right)
{
	return ((left + 0) >= (right + 0))
}

# quicksort.awk --- Quicksort algorithm, with user-supplied
#                   comparison function
#
# Arnold Robbins, arnold@skeeve.com, Public Domain
# January 2009

# quicksort --- C.A.R. Hoare's quick sort algorithm. See Wikipedia
#               or almost any algorithms or computer science text
#
# Adapted from K&R-II, page 110

function quicksort(data, left, right, less_than,	i, last)
{
	if (left >= right)	# do nothing if array contains fewer
		return		# than two elements

	quicksort_swap(data, left, int((left + right) / 2))
	last = left
	for (i = left + 1; i <= right; i++)
		if (@less_than(data[i], data[left]))
			quicksort_swap(data, ++last, i)
	quicksort_swap(data, left, last)
	quicksort(data, left, last - 1, less_than)
	quicksort(data, last + 1, right, less_than)
}

# quicksort_swap --- helper function for quicksort, should really be inline

function quicksort_swap(data, i, j,	temp)
{
	temp = data[i]
	data[i] = data[j]
	data[j] = temp
}
