

# <dt><code>atan2(<var>y</var>, <var>x</var>)</code></dt>
# <dd>
# <p>Return the arctangent of <code><var>y</var> / <var>x</var></code> in radians.
# You can use &lsquo;<samp>pi = atan2(0, -1)</samp>&rsquo; to retrieve the value of
# <i>pi</i>.
# </p>
# </dd>
function awk::atan2() {}

# <dt><code>cos(<var>x</var>)</code></dt>
# <dd>
# <p>Return the cosine of <var>x</var>, with <var>x</var> in radians.
# </p>
# </dd>
function awk::cos() {}

# <dt><code>exp(<var>x</var>)</code></dt>
# <dd>
# <p>Return the exponential of <var>x</var> (<code>e ^ <var>x</var></code>) or report
# an error if <var>x</var> is out of range.  The range of values <var>x</var> can have
# depends on your machine&rsquo;s floating-point representation.
# </p>
# </dd>
function awk::exp() {}

# <dt><code>int(<var>x</var>)</code></dt>
# <dd>
# <p>Return the nearest integer to <var>x</var>, located between <var>x</var> and zero and
# truncated toward zero.
# For example, <code>int(3)</code> is 3, <code>int(3.9)</code> is 3, <code>int(-3.9)</code>
# is -3, and <code>int(-3)</code> is -3 as well.
# </p>
# 
# </dd>
function awk::int() {}

# <dt><code>log(<var>x</var>)</code></dt>
# <dd>
# <p>Return the natural logarithm of <var>x</var>, if <var>x</var> is positive;
# otherwise, return <code>NaN</code> (&ldquo;not a number&rdquo;) on IEEE 754 systems.
# Additionally, <code>gawk</code> prints a warning message when <code>x</code>
# is negative.
# </p>
# </dd>
function awk::log() {}

# <dt><code>rand()</code></dt>
# <dd>
# <p>Return a random number.  The values of <code>rand()</code> are
# uniformly distributed between zero and one.
# The value could be zero but is never one.
# </p>
# <p>Often random integers are needed instead.  Following is a user-defined function
# that can be used to obtain a random nonnegative integer less than <var>n</var>:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">function randint(n)
# {
# &nbsp;&nbsp;&nbsp;&nbsp;return int(n * rand())
# }
# </pre></div>
# 
# <p>The multiplication produces a random number greater than or equal to
# zero and less than <code>n</code>.  Using <code>int()</code>, this result is made into
# an integer between zero and <code>n</code> - 1, inclusive.
# </p>
# <p>The following example uses a similar function to produce random integers
# between one and <var>n</var>.  This program prints a new random number for
# each input record:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example"># Function to roll a simulated die.
# function roll(n) { return 1 + int(rand() * n) }
# 
# # Roll 3 six-sided dice and
# # print total number of points.
# {
# &nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;%d points\n&quot;, roll(6) + roll(6) + roll(6))
# }
# </pre></div>
# 
# <blockquote>
# <p><b>CAUTION:</b> In most <code>awk</code> implementations, including <code>gawk</code>,
# <code>rand()</code> starts generating numbers from the same
# starting number, or <em>seed</em>, each time you run <code>awk</code>.  Thus,
# a program generates the same results each time you run it.
# The numbers are random within one <code>awk</code> run but predictable
# from run to run.  This is convenient for debugging, but if you want
# a program to do different things each time it is used, you must change
# the seed to a value that is different in each run.  To do this,
# use <code>srand()</code>.
# </p></blockquote>
# 
# </dd>
function awk::rand() {}

# <dt><code>sin(<var>x</var>)</code></dt>
# <dd>
# <p>Return the sine of <var>x</var>, with <var>x</var> in radians.
# </p>
# </dd>
function awk::sin() {}

# <dt><code>sqrt(<var>x</var>)</code></dt>
# <dd>
# <p>Return the positive square root of <var>x</var>.
# <code>gawk</code> prints a warning message
# if <var>x</var> is negative.  Thus, <code>sqrt(4)</code> is 2.
# </p>
# </dd>
function awk::sqrt() {}

# <dt><code>srand(</code>[<var>x</var>]<code>)</code></dt>
# <dd>
# <p>Set the starting point, or seed,
# for generating random numbers to the value <var>x</var>.
# </p>
# <p>Each seed value leads to a particular sequence of random
# numbers.
# Thus, if the seed is set to the same value a second time,
# the same sequence of random numbers is produced again.
# </p>
# <blockquote>
# <p><b>CAUTION:</b> Different <code>awk</code> implementations use different random-number
# generators internally.  Don&rsquo;t expect the same <code>awk</code> program
# to produce the same series of random numbers when executed by
# different versions of <code>awk</code>.
# </p></blockquote>
# 
# <p>If the argument <var>x</var> is omitted, as in &lsquo;<samp>srand()</samp>&rsquo;, then the current
# date and time of day are used for a seed.  This is the way to get random
# numbers that are truly unpredictable.
# </p>
# <p>The return value of <code>srand()</code> is the previous seed.  This makes it
# easy to keep track of the seeds in case you need to consistently reproduce
# sequences of random numbers.
# </p>
# <p>POSIX does not specify the initial seed; it differs among <code>awk</code>
# implementations.
# </p></dd>
function awk::srand() {}

# <dt><code>asort(</code><var>source</var> [<code>,</code> <var>dest</var> [<code>,</code> <var>how</var> ] ]<code>)</code></dt>
# <dt><code>asorti(</code><var>source</var> [<code>,</code> <var>dest</var> [<code>,</code> <var>how</var> ] ]<code>)</code></dt>
# <dd>
# <p>These two functions are similar in behavior, so they are described
# together.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The following description ignores the third argument, <var>how</var>, as it
# requires understanding features that we have not discussed yet.  Thus,
# the discussion here is a deliberate simplification.  (We do provide all
# the details later on; see <a href="https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a> for the full story.)
# </p></blockquote>
# 
# <p>Both functions return the number of elements in the array <var>source</var>.
# For <code>asort()</code>, <code>gawk</code> sorts the values of <var>source</var>
# and replaces the indices of the sorted values of <var>source</var> with
# sequential integers starting with one.  If the optional array <var>dest</var>
# is specified, then <var>source</var> is duplicated into <var>dest</var>.  <var>dest</var>
# is then sorted, leaving the indices of <var>source</var> unchanged.
# </p>
# <p>When comparing strings, <code>IGNORECASE</code> affects the sorting
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a>).  If the
# <var>source</var> array contains subarrays as values (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Arrays-of-Arrays.html">Arrays of Arrays</a>), they will come last, after all scalar values.
# Subarrays are <em>not</em> recursively sorted.
# </p>
# <p>For example, if the contents of <code>a</code> are as follows:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[&quot;last&quot;] = &quot;de&quot;
# a[&quot;first&quot;] = &quot;sac&quot;
# a[&quot;middle&quot;] = &quot;cul&quot;
# </pre></div>
# 
# <p>A call to <code>asort()</code>:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">asort(a)
# </pre></div>
# 
# <p>results in the following contents of <code>a</code>:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[1] = &quot;cul&quot;
# a[2] = &quot;de&quot;
# a[3] = &quot;sac&quot;
# </pre></div>
# 
# <p>The <code>asorti()</code> function works similarly to <code>asort()</code>; however,
# the <em>indices</em> are sorted, instead of the values. Thus, in the
# previous example, starting with the same initial set of indices and
# values in <code>a</code>, calling &lsquo;<samp>asorti(a)</samp>&rsquo; would yield:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[1] = &quot;first&quot;
# a[2] = &quot;last&quot;
# a[3] = &quot;middle&quot;
# </pre></div>
# 
# <blockquote>
# <p><b>NOTE:</b> You may not use either <code>SYMTAB</code> or <code>FUNCTAB</code> as the second
# argument to these functions.  Attempting to do so produces a fatal error.
# You may use them as the first argument, but only if providing a second
# array to use for the actual sorting.
# </p></blockquote>
# 
# <p>You are allowed to use the same array for both the <var>source</var> and <var>dest</var>
# arguments, but doing so only makes sense if you&rsquo;re also supplying the third argument.
# </p>
# </dd>
function gawk::asort() {}

# <dt><code>asort(</code><var>source</var> [<code>,</code> <var>dest</var> [<code>,</code> <var>how</var> ] ]<code>)</code></dt>
# <dt><code>asorti(</code><var>source</var> [<code>,</code> <var>dest</var> [<code>,</code> <var>how</var> ] ]<code>)</code></dt>
# <dd>
# <p>These two functions are similar in behavior, so they are described
# together.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The following description ignores the third argument, <var>how</var>, as it
# requires understanding features that we have not discussed yet.  Thus,
# the discussion here is a deliberate simplification.  (We do provide all
# the details later on; see <a href="https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a> for the full story.)
# </p></blockquote>
# 
# <p>Both functions return the number of elements in the array <var>source</var>.
# For <code>asort()</code>, <code>gawk</code> sorts the values of <var>source</var>
# and replaces the indices of the sorted values of <var>source</var> with
# sequential integers starting with one.  If the optional array <var>dest</var>
# is specified, then <var>source</var> is duplicated into <var>dest</var>.  <var>dest</var>
# is then sorted, leaving the indices of <var>source</var> unchanged.
# </p>
# <p>When comparing strings, <code>IGNORECASE</code> affects the sorting
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a>).  If the
# <var>source</var> array contains subarrays as values (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Arrays-of-Arrays.html">Arrays of Arrays</a>), they will come last, after all scalar values.
# Subarrays are <em>not</em> recursively sorted.
# </p>
# <p>For example, if the contents of <code>a</code> are as follows:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[&quot;last&quot;] = &quot;de&quot;
# a[&quot;first&quot;] = &quot;sac&quot;
# a[&quot;middle&quot;] = &quot;cul&quot;
# </pre></div>
# 
# <p>A call to <code>asort()</code>:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">asort(a)
# </pre></div>
# 
# <p>results in the following contents of <code>a</code>:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[1] = &quot;cul&quot;
# a[2] = &quot;de&quot;
# a[3] = &quot;sac&quot;
# </pre></div>
# 
# <p>The <code>asorti()</code> function works similarly to <code>asort()</code>; however,
# the <em>indices</em> are sorted, instead of the values. Thus, in the
# previous example, starting with the same initial set of indices and
# values in <code>a</code>, calling &lsquo;<samp>asorti(a)</samp>&rsquo; would yield:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[1] = &quot;first&quot;
# a[2] = &quot;last&quot;
# a[3] = &quot;middle&quot;
# </pre></div>
# 
# <blockquote>
# <p><b>NOTE:</b> You may not use either <code>SYMTAB</code> or <code>FUNCTAB</code> as the second
# argument to these functions.  Attempting to do so produces a fatal error.
# You may use them as the first argument, but only if providing a second
# array to use for the actual sorting.
# </p></blockquote>
# 
# <p>You are allowed to use the same array for both the <var>source</var> and <var>dest</var>
# arguments, but doing so only makes sense if you&rsquo;re also supplying the third argument.
# </p>
# </dd>
function gawk::asorti() {}

# <dt><code>gensub(<var>regexp</var>, <var>replacement</var>, <var>how</var></code> [<code>, <var>target</var></code>]<code>)</code></dt>
# <dd>
# <p>Search the target string <var>target</var> for matches of the regular
# expression <var>regexp</var>.  If <var>how</var> is a string beginning with
# &lsquo;<samp>g</samp>&rsquo; or &lsquo;<samp>G</samp>&rsquo; (short for &ldquo;global&rdquo;), then replace all matches
# of <var>regexp</var> with <var>replacement</var>.  Otherwise, treat <var>how</var>
# as a number indicating which match of <var>regexp</var> to replace.  Treat
# numeric values less than one as if they were one.  If no <var>target</var>
# is supplied, use <code>$0</code>.  Return the modified string as the result
# of the function. The original target string is <em>not</em> changed.
# </p>
# <p>The returned value is <em>always</em> a string, even if the original
# <var>target</var> was a number or a regexp value.
# </p>
# <p><code>gensub()</code> is a general substitution function.  Its purpose is
# to provide more features than the standard <code>sub()</code> and <code>gsub()</code>
# functions.
# </p>
# <p><code>gensub()</code> provides an additional feature that is not available
# in <code>sub()</code> or <code>gsub()</code>: the ability to specify components of a
# regexp in the replacement text.  This is done by using parentheses in
# the regexp to mark the components and then specifying &lsquo;<samp>\<var>N</var></samp>&rsquo;
# in the replacement text, where <var>N</var> is a digit from 1 to 9.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>gawk '</kbd>
# &gt; <kbd>BEGIN {</kbd>
# &gt;      <kbd>a = &quot;abc def&quot;</kbd>
# &gt;      <kbd>b = gensub(/(.+) (.+)/, &quot;\\2 \\1&quot;, &quot;g&quot;, a)</kbd>
# &gt;      <kbd>print b</kbd>
# &gt; <kbd>}'</kbd>
# -| def abc
# </pre></div>
# 
# <p>As with <code>sub()</code>, you must type two backslashes in order
# to get one into the string.
# In the replacement text, the sequence &lsquo;<samp>\0</samp>&rsquo; represents the entire
# matched text, as does the character &lsquo;<samp>&amp;</samp>&rsquo;.
# </p>
# <p>The following example shows how you can use the third argument to control
# which match of the regexp should be changed:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>echo a b c a b c |</kbd>
# &gt; <kbd>gawk '{ print gensub(/a/, &quot;AA&quot;, 2) }'</kbd>
# -| a b c AA b c
# </pre></div>
# 
# <p>In this case, <code>$0</code> is the default target string.
# <code>gensub()</code> returns the new string as its result, which is
# passed directly to <code>print</code> for printing.
# </p>
# <p>If the <var>how</var> argument is a string that does not begin with &lsquo;<samp>g</samp>&rsquo; or
# &lsquo;<samp>G</samp>&rsquo;, or if it is a number that is less than or equal to zero, only one
# substitution is performed.  If <var>how</var> is zero, <code>gawk</code> issues
# a warning message.
# </p>
# <p>If <var>regexp</var> does not match <var>target</var>, <code>gensub()</code>&rsquo;s return value
# is the original unchanged value of <var>target</var>.  Note that, as mentioned
# above, the returned value is a string, even if <var>target</var> was not.
# </p>
# </dd>
function gawk::gensub() {}

# <dt><code>gsub(<var>regexp</var>, <var>replacement</var></code> [<code>, <var>target</var></code>]<code>)</code></dt>
# <dd>
# <p>Search <var>target</var> for
# <em>all</em> of the longest, leftmost, <em>nonoverlapping</em> matching
# substrings it can find and replace them with <var>replacement</var>.
# The &lsquo;<samp>g</samp>&rsquo; in <code>gsub()</code> stands for
# &ldquo;global,&rdquo; which means replace everywhere.  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">{ gsub(/Britain/, &quot;United Kingdom&quot;); print }
# </pre></div>
# 
# <p>replaces all occurrences of the string &lsquo;<samp>Britain</samp>&rsquo; with &lsquo;<samp>United
# Kingdom</samp>&rsquo; for all input records.
# </p>
# <p>The <code>gsub()</code> function returns the number of substitutions made.  If
# the variable to search and alter (<var>target</var>) is
# omitted, then the entire input record (<code>$0</code>) is used.
# As in <code>sub()</code>, the characters &lsquo;<samp>&amp;</samp>&rsquo; and &lsquo;<samp>\</samp>&rsquo; are special,
# and the third argument must be assignable.
# </p>
# </dd>
function awk::gsub() {}

# <dt><code>index(<var>in</var>, <var>find</var>)</code></dt>
# <dd>
# <p>Search the string <var>in</var> for the first occurrence of the string
# <var>find</var>, and return the position in characters where that occurrence
# begins in the string <var>in</var>.  Consider the following example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>awk 'BEGIN { print index(&quot;peanut&quot;, &quot;an&quot;) }'</kbd>
# -| 3
# </pre></div>
# 
# <p>If <var>find</var> is not found, <code>index()</code> returns zero.
# </p>
# <p>With BWK <code>awk</code> and <code>gawk</code>,
# it is a fatal error to use a regexp constant for <var>find</var>.
# Other implementations allow it, simply treating the regexp
# constant as an expression meaning &lsquo;<samp>$0 ~ /regexp/</samp>&rsquo;. (d.c.)
# </p>
# </dd>
function awk::index() {}

# <dt><code>length(</code>[<var>string</var>]<code>)</code></dt>
# <dd>
# <p>Return the number of characters in <var>string</var>.  If
# <var>string</var> is a number, the length of the digit string representing
# that number is returned.  For example, <code>length(&quot;abcde&quot;)</code> is five.  By
# contrast, <code>length(15 * 35)</code> works out to three. In this example,
# 15 * 35 = 525,
# and 525 is then converted to the string <code>&quot;525&quot;</code>, which has
# three characters.
# </p>
# <p>If no argument is supplied, <code>length()</code> returns the length of <code>$0</code>.
# </p>
# <blockquote>
# <p><b>NOTE:</b> In older versions of <code>awk</code>, the <code>length()</code> function could
# be called
# without any parentheses.  Doing so is considered poor practice,
# although the 2008 POSIX standard explicitly allows it, to
# support historical practice.  For programs to be maximally portable,
# always supply the parentheses.
# </p></blockquote>
# 
# <p>If <code>length()</code> is called with a variable that has not been used,
# <code>gawk</code> forces the variable to be a scalar.  Other
# implementations of <code>awk</code> leave the variable without a type.
# (d.c.)
# Consider:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>gawk 'BEGIN { print length(x) ; x[1] = 1 }'</kbd>
# -| 0
# error&rarr; gawk: fatal: attempt to use scalar `x' as array
# 
# $ <kbd>nawk 'BEGIN { print length(x) ; x[1] = 1 }'</kbd>
# -| 0
# </pre></div>
# 
# <p>If <samp>--lint</samp> has
# been specified on the command line, <code>gawk</code> issues a
# warning about this.
# </p>
# <p>With <code>gawk</code> and several other <code>awk</code> implementations, when given an
# array argument, the <code>length()</code> function returns the number of elements
# in the array. (c.e.)
# This is less useful than it might seem at first, as the
# array is not guaranteed to be indexed from one to the number of elements
# in it.
# If <samp>--lint</samp> is provided on the command line
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>),
# <code>gawk</code> warns that passing an array argument is not portable.
# If <samp>--posix</samp> is supplied, using an array argument is a fatal error
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Arrays.html">Arrays in <code>awk</code></a>).
# </p>
# </dd>
function awk::length() {}

# <dt><code>match(<var>string</var>, <var>regexp</var></code> [<code>, <var>array</var></code>]<code>)</code></dt>
# <dd>
# <p>Search <var>string</var> for the
# longest, leftmost substring matched by the regular expression
# <var>regexp</var> and return the character position (index)
# at which that substring begins (one, if it starts at the beginning of
# <var>string</var>).  If no match is found, return zero.
# </p>
# <p>The <var>regexp</var> argument may be either a regexp constant
# (<code>/</code>&hellip;<code>/</code>) or a string constant (<code>&quot;</code>&hellip;<code>&quot;</code>).
# In the latter case, the string is treated as a regexp to be matched.
# See section <a href="https://www.gnu.org/software/gawk/manual/html_node/Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between the two forms, and the
# implications for writing your program correctly.
# </p>
# <p>The order of the first two arguments is the opposite of most other string
# functions that work with regular expressions, such as
# <code>sub()</code> and <code>gsub()</code>.  It might help to remember that
# for <code>match()</code>, the order is the same as for the &lsquo;<samp>~</samp>&rsquo; operator:
# &lsquo;<samp><var>string</var> ~ <var>regexp</var></samp>&rsquo;.
# </p>
# <p>The <code>match()</code> function sets the predefined variable <code>RSTART</code> to
# the index.  It also sets the predefined variable <code>RLENGTH</code> to the
# length in characters of the matched substring.  If no match is found,
# <code>RSTART</code> is set to zero, and <code>RLENGTH</code> to -1.
# </p>
# <p>For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">{
# &nbsp;&nbsp;&nbsp;&nbsp;if ($1 == &quot;FIND&quot;)
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;regex = $2
# &nbsp;&nbsp;&nbsp;&nbsp;else {
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;where = match($0, regex)
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (where != 0)
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print &quot;Match of&quot;, regex, &quot;found at&quot;, where, &quot;in&quot;, $0
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
# }
# </pre></div>
# 
# <p>This program looks for lines that match the regular expression stored in
# the variable <code>regex</code>.  This regular expression can be changed.  If the
# first word on a line is &lsquo;<samp>FIND</samp>&rsquo;, <code>regex</code> is changed to be the
# second word on that line.  Therefore, if given:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">FIND ru+n
# My program runs
# but not very quickly
# FIND Melvin
# JF+KM
# This line is property of Reality Engineering Co.
# Melvin was here.
# </pre></div>
# 
# <p><code>awk</code> prints:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">Match of ru+n found at 12 in My program runs
# Match of Melvin found at 1 in Melvin was here.
# </pre></div>
# 
# <p>If <var>array</var> is present, it is cleared, and then the zeroth element
# of <var>array</var> is set to the entire portion of <var>string</var>
# matched by <var>regexp</var>.  If <var>regexp</var> contains parentheses,
# the integer-indexed elements of <var>array</var> are set to contain the
# portion of <var>string</var> matching the corresponding parenthesized
# subexpression.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>echo foooobazbarrrrr |</kbd>
# &gt; <kbd>gawk '{ match($0, /(fo+).+(bar*)/, arr)</kbd>
# &gt;         <kbd>print arr[1], arr[2] }'</kbd>
# -| foooo barrrrr
# </pre></div>
# 
# <p>In addition,
# multidimensional subscripts are available providing
# the start index and length of each matched subexpression:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>echo foooobazbarrrrr |</kbd>
# &gt; <kbd>gawk '{ match($0, /(fo+).+(bar*)/, arr)</kbd>
# &gt;           <kbd>print arr[1], arr[2]</kbd>
# &gt;           <kbd>print arr[1, &quot;start&quot;], arr[1, &quot;length&quot;]</kbd>
# &gt;           <kbd>print arr[2, &quot;start&quot;], arr[2, &quot;length&quot;]</kbd>
# &gt; <kbd>}'</kbd>
# -| foooo barrrrr
# -| 1 5
# -| 9 7
# </pre></div>
# 
# <p>There may not be subscripts for the start and index for every parenthesized
# subexpression, because they may not all have matched text; thus, they
# should be tested for with the <code>in</code> operator
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Reference-to-Elements.html">Referring to an Array Element</a>).
# </p>
# <p>The <var>array</var> argument to <code>match()</code> is a
# <code>gawk</code> extension.  In compatibility mode
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>),
# using a third argument is a fatal error.
# </p>
# </dd>
function awk::match() {}

# <dt><code>patsplit(<var>string</var>, <var>array</var></code> [<code>, <var>fieldpat</var></code> [<code>, <var>seps</var></code> ] ]<code>)</code></dt>
# <dd>
# <p>Divide
# <var>string</var> into pieces (or &ldquo;fields&rdquo;) defined by <var>fieldpat</var>
# and store the pieces in <var>array</var> and the separator strings in the
# <var>seps</var> array.  The first piece is stored in
# <code><var>array</var>[1]</code>, the second piece in <code><var>array</var>[2]</code>, and so
# forth.  The third argument, <var>fieldpat</var>, is
# a regexp describing the fields in <var>string</var> (just as <code>FPAT</code> is
# a regexp describing the fields in input records).
# It may be either a regexp constant or a string.
# If <var>fieldpat</var> is omitted, the value of <code>FPAT</code> is used.
# <code>patsplit()</code> returns the number of elements created.
# <code><var>seps</var>[<var>i</var>]</code> is
# the possibly null separator string
# after <code><var>array</var>[<var>i</var>]</code>.
# The possibly null leading separator will be in <code><var>seps</var>[0]</code>.
# So a non-null <var>string</var> with <var>n</var> fields will have <var>n+1</var> separators.
# A null <var>string</var> has no fields or separators.
# </p>
# <p>The <code>patsplit()</code> function splits strings into pieces in a
# manner similar to the way input lines are split into fields using <code>FPAT</code>
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Splitting-By-Content.html">Defining Fields by Content</a>).
# </p>
# <p>Before splitting the string, <code>patsplit()</code> deletes any previously existing
# elements in the arrays <var>array</var> and <var>seps</var>.
# </p>
# </dd>
function gawk::patsplit() {}

# <dt><code>split(<var>string</var>, <var>array</var></code> [<code>, <var>fieldsep</var></code> [<code>, <var>seps</var></code> ] ]<code>)</code></dt>
# <dd>
# <p>Divide <var>string</var> into pieces separated by <var>fieldsep</var>
# and store the pieces in <var>array</var> and the separator strings in the
# <var>seps</var> array.  The first piece is stored in
# <code><var>array</var>[1]</code>, the second piece in <code><var>array</var>[2]</code>, and so
# forth.  The string value of the third argument, <var>fieldsep</var>, is
# a regexp describing where to split <var>string</var> (much as <code>FS</code> can
# be a regexp describing where to split input records).
# If <var>fieldsep</var> is omitted, the value of <code>FS</code> is used.
# <code>split()</code> returns the number of elements created.
# <var>seps</var> is a <code>gawk</code> extension, with <code><var>seps</var>[<var>i</var>]</code>
# being the separator string
# between <code><var>array</var>[<var>i</var>]</code> and <code><var>array</var>[<var>i</var>+1]</code>.
# If <var>fieldsep</var> is a single
# space, then any leading whitespace goes into <code><var>seps</var>[0]</code> and
# any trailing
# whitespace goes into <code><var>seps</var>[<var>n</var>]</code>, where <var>n</var> is the
# return value of
# <code>split()</code> (i.e., the number of elements in <var>array</var>).
# </p>
# <p>The <code>split()</code> function splits strings into pieces in the same way
# that input lines are split into fields.  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">split(&quot;cul-de-sac&quot;, a, &quot;-&quot;, seps)
# </pre></div>
# 
# <p>
# splits the string <code>&quot;cul-de-sac&quot;</code> into three fields using &lsquo;<samp>-</samp>&rsquo; as the
# separator.  It sets the contents of the array <code>a</code> as follows:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">a[1] = &quot;cul&quot;
# a[2] = &quot;de&quot;
# a[3] = &quot;sac&quot;
# </pre></div>
# 
# <p>and sets the contents of the array <code>seps</code> as follows:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">seps[1] = &quot;-&quot;
# seps[2] = &quot;-&quot;
# </pre></div>
# 
# <p>The value returned by this call to <code>split()</code> is three.
# </p>
# <p>As with input field-splitting, when the value of <var>fieldsep</var> is
# <code>&quot;&nbsp;&quot;</code><!-- /@w -->, leading and trailing whitespace is ignored in values assigned to
# the elements of
# <var>array</var> but not in <var>seps</var>, and the elements
# are separated by runs of whitespace.
# Also, as with input field splitting, if <var>fieldsep</var> is the null string, each
# individual character in the string is split into its own array element.
# (c.e.)
# Additionally, if <var>fieldsep</var> is a single-character string, that string acts
# as the separator, even if its value is a regular expression metacharacter.
# </p>
# <p>Note, however, that <code>RS</code> has no effect on the way <code>split()</code>
# works. Even though &lsquo;<samp>RS = &quot;&quot;</samp>&rsquo; causes the newline character to also be an input
# field separator, this does not affect how <code>split()</code> splits strings.
# </p>
# <p>Modern implementations of <code>awk</code>, including <code>gawk</code>, allow
# the third argument to be a regexp constant (<code>/</code>&hellip;<code>/</code><!-- /@w -->)
# as well as a string.  (d.c.)
# The POSIX standard allows this as well.
# See section <a href="https://www.gnu.org/software/gawk/manual/html_node/Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between using a string constant or a regexp constant,
# and the implications for writing your program correctly.
# </p>
# <p>Before splitting the string, <code>split()</code> deletes any previously existing
# elements in the arrays <var>array</var> and <var>seps</var>.
# </p>
# <p>If <var>string</var> is null, the array has no elements. (So this is a portable
# way to delete an entire array with one statement.
# See section <a href="https://www.gnu.org/software/gawk/manual/html_node/Delete.html">The <code>delete</code> Statement</a>.)
# </p>
# <p>If <var>string</var> does not match <var>fieldsep</var> at all (but is not null),
# <var>array</var> has one element only. The value of that element is the original
# <var>string</var>.
# </p>
# <p>In POSIX mode (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>), the fourth argument is not allowed.
# </p>
# </dd>
function awk::split() {}

# <dt><code>sprintf(<var>format</var>, <var>expression1</var>, &hellip;)</code></dt>
# <dd>
# <p>Return (without printing) the string that <code>printf</code> would
# have printed out with the same arguments
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Printf.html">Using <code>printf</code> Statements for Fancier Printing</a>).
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">pival = sprintf(&quot;pi = %.2f (approx.)&quot;, 22/7)
# </pre></div>
# 
# <p>assigns the string &lsquo;<samp>pi&nbsp;=&nbsp;3.14&nbsp;(approx.)</samp>&rsquo;<!-- /@w --> to the variable <code>pival</code>.
# </p>
# </dd>
function awk::sprintf() {}

# <dt><code>strtonum(<var>str</var>)</code></dt>
# <dd><p>Examine <var>str</var> and return its numeric value.  If <var>str</var>
# begins with a leading &lsquo;<samp>0</samp>&rsquo;, <code>strtonum()</code> assumes that <var>str</var>
# is an octal number.  If <var>str</var> begins with a leading &lsquo;<samp>0x</samp>&rsquo; or
# &lsquo;<samp>0X</samp>&rsquo;, <code>strtonum()</code> assumes that <var>str</var> is a hexadecimal number.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>echo 0x11 |</kbd>
# &gt; <kbd>gawk '{ printf &quot;%d\n&quot;, strtonum($1) }'</kbd>
# -| 17
# </pre></div>
# 
# <p>Using the <code>strtonum()</code> function is <em>not</em> the same as adding zero
# to a string value; the automatic coercion of strings to numbers
# works only for decimal data, not for octal or hexadecimal.
# </p>
# <p>Note also that <code>strtonum()</code> uses the current locale&rsquo;s decimal point
# for recognizing numbers (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Locales.html">Where You Are Makes a Difference</a>).
# </p>
# </dd>
function gawk::strtonum() {}

# <dt><code>sub(<var>regexp</var>, <var>replacement</var></code> [<code>, <var>target</var></code>]<code>)</code></dt>
# <dd>
# <p>Search <var>target</var>, which is treated as a string, for the
# leftmost, longest substring matched by the regular expression <var>regexp</var>.
# Modify the entire string
# by replacing the matched text with <var>replacement</var>.
# The modified string becomes the new value of <var>target</var>.
# Return the number of substitutions made (zero or one).
# </p>
# <p>The <var>regexp</var> argument may be either a regexp constant
# (<code>/</code>&hellip;<code>/</code>) or a string constant (<code>&quot;</code>&hellip;<code>&quot;</code>).
# In the latter case, the string is treated as a regexp to be matched.
# See section <a href="https://www.gnu.org/software/gawk/manual/html_node/Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between the two forms, and the
# implications for writing your program correctly.
# </p>
# <p>This function is peculiar because <var>target</var> is not simply
# used to compute a value, and not just any expression will do&mdash;it
# must be a variable, field, or array element so that <code>sub()</code> can
# store a modified value there.  If this argument is omitted, then the
# default is to use and alter <code>$0</code>.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">str = &quot;water, water, everywhere&quot;
# sub(/at/, &quot;ith&quot;, str)
# </pre></div>
# 
# <p>sets <code>str</code> to &lsquo;<samp>wither,&nbsp;water,&nbsp;everywhere</samp>&rsquo;<!-- /@w -->, by replacing the
# leftmost longest occurrence of &lsquo;<samp>at</samp>&rsquo; with &lsquo;<samp>ith</samp>&rsquo;.
# </p>
# <p>If the special character &lsquo;<samp>&amp;</samp>&rsquo; appears in <var>replacement</var>, it
# stands for the precise substring that was matched by <var>regexp</var>.  (If
# the regexp can match more than one string, then this precise substring
# may vary.)  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">{ sub(/candidate/, &quot;&amp; and his wife&quot;); print }
# </pre></div>
# 
# <p>changes the first occurrence of &lsquo;<samp>candidate</samp>&rsquo; to &lsquo;<samp>candidate
# and his wife</samp>&rsquo; on each input line.
# Here is another example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>awk 'BEGIN {</kbd>
# &gt;         <kbd>str = &quot;daabaaa&quot;</kbd>
# &gt;         <kbd>sub(/a+/, &quot;C&amp;C&quot;, str)</kbd>
# &gt;         <kbd>print str</kbd>
# &gt; <kbd>}'</kbd>
# -| dCaaCbaaa
# </pre></div>
# 
# <p>This shows how &lsquo;<samp>&amp;</samp>&rsquo; can represent a nonconstant string and also
# illustrates the &ldquo;leftmost, longest&rdquo; rule in regexp matching
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Leftmost-Longest.html">How Much Text Matches?</a>).
# </p>
# <p>The effect of this special character (&lsquo;<samp>&amp;</samp>&rsquo;) can be turned off by putting a
# backslash before it in the string.  As usual, to insert one backslash in
# the string, you must write two backslashes.  Therefore, write &lsquo;<samp>\\&amp;</samp>&rsquo;
# in a string constant to include a literal &lsquo;<samp>&amp;</samp>&rsquo; in the replacement.
# For example, the following shows how to replace the first &lsquo;<samp>|</samp>&rsquo; on each line with
# an &lsquo;<samp>&amp;</samp>&rsquo;:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">{ sub(/\|/, &quot;\\&amp;&quot;); print }
# </pre></div>
# 
# <p>As mentioned, the third argument to <code>sub()</code> must
# be a variable, field, or array element.
# Some versions of <code>awk</code> allow the third argument to
# be an expression that is not an lvalue.  In such a case, <code>sub()</code>
# still searches for the pattern and returns zero or one, but the result of
# the substitution (if any) is thrown away because there is no place
# to put it.  Such versions of <code>awk</code> accept expressions
# like the following:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">sub(/USA/, &quot;United States&quot;, &quot;the USA and Canada&quot;)
# </pre></div>
# 
# <p>
# For historical compatibility, <code>gawk</code> accepts such erroneous code.
# However, using any other nonchangeable
# object as the third parameter causes a fatal error and your program
# will not run.
# </p>
# <p>Finally, if the <var>regexp</var> is not a regexp constant, it is converted into a
# string, and then the value of that string is treated as the regexp to match.
# </p>
# </dd>
function awk::sub() {}

# <dt><code>substr(<var>string</var>, <var>start</var></code> [<code>, <var>length</var></code> ]<code>)</code></dt>
# <dd>
# <p>Return a <var>length</var>-character-long substring of <var>string</var>,
# starting at character number <var>start</var>.  The first character of a
# string is character number one.
# For example, <code>substr(&quot;washington&quot;, 5, 3)</code> returns <code>&quot;ing&quot;</code>.
# </p>
# <p>If <var>length</var> is not present, <code>substr()</code> returns the whole suffix of
# <var>string</var> that begins at character number <var>start</var>.  For example,
# <code>substr(&quot;washington&quot;, 5)</code> returns <code>&quot;ington&quot;</code>.  The whole
# suffix is also returned
# if <var>length</var> is greater than the number of characters remaining
# in the string, counting from character <var>start</var>.
# </p>
# <p>If <var>start</var> is less than one, <code>substr()</code> treats it as
# if it was one. (POSIX doesn&rsquo;t specify what to do in this case:
# BWK <code>awk</code> acts this way, and therefore <code>gawk</code>
# does too.)
# If <var>start</var> is greater than the number of characters
# in the string, <code>substr()</code> returns the null string.
# Similarly, if <var>length</var> is present but less than or equal to zero,
# the null string is returned.
# </p>
# <p>The string returned by <code>substr()</code> <em>cannot</em> be
# assigned.  Thus, it is a mistake to attempt to change a portion of
# a string, as shown in the following example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">string = &quot;abcdef&quot;
# # try to get &quot;abCDEf&quot;, won't work
# substr(string, 3, 3) = &quot;CDE&quot;
# </pre></div>
# 
# <p>It is also a mistake to use <code>substr()</code> as the third argument
# of <code>sub()</code> or <code>gsub()</code>:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">gsub(/xyz/, &quot;pdq&quot;, substr($0, 5, 20))  # WRONG
# </pre></div>
# 
# <p>(Some commercial versions of <code>awk</code> treat
# <code>substr()</code> as assignable, but doing so is not portable.)
# </p>
# <p>If you need to replace bits and pieces of a string, combine <code>substr()</code>
# with string concatenation, in the following manner:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">string = &quot;abcdef&quot;
# &hellip;
# string = substr(string, 1, 2) &quot;CDE&quot; substr(string, 6)
# </pre></div>
# 
# </dd>
function awk::substr() {}

# <dt><code>tolower(<var>string</var>)</code></dt>
# <dd>
# <p>Return a copy of <var>string</var>, with each uppercase character
# in the string replaced with its corresponding lowercase character.
# Nonalphabetic characters are left unchanged.  For example,
# <code>tolower(&quot;MiXeD cAsE 123&quot;)</code> returns <code>&quot;mixed case 123&quot;</code>.
# </p>
# </dd>
function awk::tolower() {}

# <dt><code>toupper(<var>string</var>)</code></dt>
# <dd>
# <p>Return a copy of <var>string</var>, with each lowercase character
# in the string replaced with its corresponding uppercase character.
# Nonalphabetic characters are left unchanged.  For example,
# <code>toupper(&quot;MiXeD cAsE 123&quot;)</code> returns <code>&quot;MIXED CASE 123&quot;</code>.
# </p></dd>
function awk::toupper() {}

# <dt><code>close(</code><var>filename</var> [<code>,</code> <var>how</var>]<code>)</code></dt>
# <dd>
# <p>Close the file <var>filename</var> for input or output. Alternatively, the
# argument may be a shell command that was used for creating a coprocess, or
# for redirecting to or from a pipe; then the coprocess or pipe is closed.
# See section <a href="https://www.gnu.org/software/gawk/manual/html_node/Close-Files-And-Pipes.html">Closing Input and Output Redirections</a>
# for more information.
# </p>
# <p>When closing a coprocess, it is occasionally useful to first close
# one end of the two-way pipe and then to close the other.  This is done
# by providing a second argument to <code>close()</code>.  This second argument
# (<var>how</var>)
# should be one of the two string values <code>&quot;to&quot;</code> or <code>&quot;from&quot;</code>,
# indicating which end of the pipe to close.  Case in the string does
# not matter.
# See section <a href="https://www.gnu.org/software/gawk/manual/html_node/Two_002dway-I_002fO.html">Two-Way Communications with Another Process</a>,
# which discusses this feature in more detail and gives an example.
# </p>
# <p>Note that the second argument to <code>close()</code> is a <code>gawk</code>
# extension; it is not available in compatibility mode (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>).
# </p>
# </dd>
function awk::close() {}

# <dt><code>fflush(</code>[<var>filename</var>]<code>)</code></dt>
# <dd>
# <p>Flush any buffered output associated with <var>filename</var>, which is either a
# file opened for writing or a shell command for redirecting output to
# a pipe or coprocess.
# </p>
# <p>Many utility programs <em>buffer</em> their output (i.e., they save information
# to write to a disk file or the screen in memory until there is enough
# for it to be worthwhile to send the data to the output device).
# This is often more efficient than writing
# every little bit of information as soon as it is ready.  However, sometimes
# it is necessary to force a program to <em>flush</em> its buffers (i.e.,
# write the information to its destination, even if a buffer is not full).
# This is the purpose of the <code>fflush()</code> function&mdash;<code>gawk</code> also
# buffers its output, and the <code>fflush()</code> function forces
# <code>gawk</code> to flush its buffers.
# </p>
# <p>Brian Kernighan added <code>fflush()</code> to his <code>awk</code> in April
# 1992.  For two decades, it was a common extension.  In December
# 2012, it was accepted for inclusion into the POSIX standard.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/http://austingroupbugs.net/view.php?id=634">the Austin Group website</a>.
# </p>
# <p>POSIX standardizes <code>fflush()</code> as follows: if there
# is no argument, or if the argument is the null string (<code>&quot;&quot;</code><!-- /@w -->),
# then <code>awk</code> flushes the buffers for <em>all</em> open output files
# and pipes.
# </p>
# <blockquote>
# <p><b>NOTE:</b> Prior to version 4.0.2, <code>gawk</code>
# would flush only the standard output if there was no argument,
# and flush all output files and pipes if the argument was the null
# string. This was changed in order to be compatible with BWK
# <code>awk</code>, in the hope that standardizing this
# feature in POSIX would then be easier (which indeed proved to be the case).
# </p>
# <p>With <code>gawk</code>,
# you can use &lsquo;<samp>fflush(&quot;/dev/stdout&quot;)</samp>&rsquo; if you wish to flush
# only the standard output.
# </p></blockquote>
# 
# <p><code>fflush()</code> returns zero if the buffer is successfully flushed;
# otherwise, it returns a nonzero value. (<code>gawk</code> returns -1.)
# In the case where all buffers are flushed, the return value is zero
# only if all buffers were flushed successfully.  Otherwise, it is
# -1, and <code>gawk</code> warns about the problem <var>filename</var>.
# </p>
# <p><code>gawk</code> also issues a warning message if you attempt to flush
# a file or pipe that was opened for reading (such as with <code>getline</code>),
# or if <var>filename</var> is not an open file, pipe, or coprocess.
# In such a case, <code>fflush()</code> returns -1, as well.
# </p>
# </dd>
function awk::fflush() {}

# <dt><code>system(<var>command</var>)</code></dt>
# <dd>
# <p>Execute the operating system
# command <var>command</var> and then return to the <code>awk</code> program.
# Return <var>command</var>&rsquo;s exit status (see further on).
# </p>
# <p>For example, if the following fragment of code is put in your <code>awk</code>
# program:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">END {
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;system(&quot;date | mail -s 'awk run done' root&quot;)
# }
# </pre></div>
# 
# <p>the system administrator is sent mail when the <code>awk</code> program
# finishes processing input and begins its end-of-input processing.
# </p>
# <p>Note that redirecting <code>print</code> or <code>printf</code> into a pipe is often
# enough to accomplish your task.  If you need to run many commands, it
# is more efficient to simply print them down a pipeline to the shell:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">while (<var>more stuff to do</var>)
# &nbsp;&nbsp;&nbsp;&nbsp;print <var>command</var> | &quot;/bin/sh&quot;
# close(&quot;/bin/sh&quot;)
# </pre></div>
# 
# <p>
# However, if your <code>awk</code>
# program is interactive, <code>system()</code> is useful for running large
# self-contained programs, such as a shell or an editor.
# Some operating systems cannot implement the <code>system()</code> function.
# <code>system()</code> causes a fatal error if it is not supported.
# </p>
# <blockquote>
# <p><b>NOTE:</b> When <samp>--sandbox</samp> is specified, the <code>system()</code> function is disabled
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>).
# </p></blockquote>
# 
# <p>On POSIX systems, a command&rsquo;s exit status is a 16-bit number. The exit
# value passed to the C <code>exit()</code> function is held in the high-order
# eight bits. The low-order bits indicate if the process was killed by a
# signal (bit 7) and if so, the guilty signal number (bits 0&ndash;6).
# </p>
# <p>Traditionally, <code>awk</code>&rsquo;s <code>system()</code> function has simply
# returned the exit status value divided by 256. In the normal case this
# gives the exit status but in the case of death-by-signal it yields
# a fractional floating-point value. POSIX states that <code>awk</code>&rsquo;s
# <code>system()</code> should return the full 16-bit value.
# </p>
# <p><code>gawk</code> steers a middle ground.
# The return values are summarized in <a href="https://www.gnu.org/software/gawk/manual/html_node/#table_002dsystem_002dreturn_002dvalues">Table 9.5</a>.
# </p>
# <div class="float">
# 
# <table>
# <thead><tr><th width="40%">Situation</th><th width="60%">Return value from <code>system()</code></th></tr></thead>
# <tr><td width="40%"><samp>--traditional</samp></td><td width="60%">C <code>system()</code>&rsquo;s value divided by 256</td></tr>
# <tr><td width="40%"><samp>--posix</samp></td><td width="60%">C <code>system()</code>&rsquo;s value</td></tr>
# <tr><td width="40%">Normal exit of command</td><td width="60%">Command&rsquo;s exit status</td></tr>
# <tr><td width="40%">Death by signal of command</td><td width="60%">256 + number of murderous signal</td></tr>
# <tr><td width="40%">Death by signal of command with core dump</td><td width="60%">512 + number of murderous signal</td></tr>
# <tr><td width="40%">Some kind of error</td><td width="60%">-1</td></tr>
# </table>
# <div class="float-caption"><p><strong>Table 9.5: </strong>Return values from <code>system()</code></p></div></div></dd>
function awk::system() {}

# <dt><code>mktime(<var>datespec</var></code> [<code>, <var>utc-flag</var></code> ]<code>)</code></dt>
# <dd>
# <p>Turn <var>datespec</var> into a timestamp in the same form
# as is returned by <code>systime()</code>.  It is similar to the function of the
# same name in ISO C.  The argument, <var>datespec</var>, is a string of the form
# <code>&quot;<var>YYYY</var>&nbsp;<var>MM</var>&nbsp;<var>DD</var>&nbsp;<var>HH</var>&nbsp;<var>MM</var>&nbsp;<var>SS</var>&nbsp;[<var>DST</var>]&quot;</code><!-- /@w -->.
# The string consists of six or seven numbers representing, respectively,
# the full year including century, the month from 1 to 12, the day of the month
# from 1 to 31, the hour of the day from 0 to 23, the minute from 0 to
# 59, the second from 0 to 60,
# and an optional daylight-savings flag.
# </p>
# <p>The values of these numbers need not be within the ranges specified;
# for example, an hour of -1 means 1 hour before midnight.
# The origin-zero Gregorian calendar is assumed, with year 0 preceding
# year 1 and year -1 preceding year 0.
# If <var>utc-flag</var> is present and is either nonzero or non-null, the time
# is assumed to be in the UTC time zone; otherwise, the
# time is assumed to be in the local time zone.
# If the <var>DST</var> daylight-savings flag is positive, the time is assumed to be
# daylight savings time; if zero, the time is assumed to be standard
# time; and if negative (the default), <code>mktime()</code> attempts to determine
# whether daylight savings time is in effect for the specified time.
# </p>
# <p>If <var>datespec</var> does not contain enough elements or if the resulting time
# is out of range, <code>mktime()</code> returns -1.
# </p>
# </dd>
function gawk::mktime() {}

# <dt><code>strftime(</code>[<var>format</var> [<code>,</code> <var>timestamp</var> [<code>,</code> <var>utc-flag</var>] ] ]<code>)</code></dt>
# <dd>
# <p>Format the time specified by <var>timestamp</var>
# based on the contents of the <var>format</var> string and return the result.
# It is similar to the function of the same name in ISO C.
# If <var>utc-flag</var> is present and is either nonzero or non-null, the value
# is formatted as UTC (Coordinated Universal Time, formerly GMT or Greenwich
# Mean Time). Otherwise, the value is formatted for the local time zone.
# The <var>timestamp</var> is in the same format as the value returned by the
# <code>systime()</code> function.  If no <var>timestamp</var> argument is supplied,
# <code>gawk</code> uses the current time of day as the timestamp.
# Without a <var>format</var> argument, <code>strftime()</code> uses
# the value of <code>PROCINFO[&quot;strftime&quot;]</code> as the format string
# (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Built_002din-Variables.html">Predefined Variables</a>).
# The default string value is
# <code>&quot;%a&nbsp;%b&nbsp;%e&nbsp;%H:%M:%S&nbsp;%Z&nbsp;%Y&quot;<!-- /@w --></code>.  This format string produces
# output that is equivalent to that of the <code>date</code> utility.
# You can assign a new value to <code>PROCINFO[&quot;strftime&quot;]</code> to
# change the default format; see the following list for the various format directives.
# </p>
# </dd>
function gawk::strftime() {}

# <dt><code>systime()</code></dt>
# <dd>
# <p>Return the current time as the number of seconds since
# the system epoch.  On POSIX systems, this is the number of seconds
# since 1970-01-01 00:00:00 UTC, not counting leap seconds.
# It may be a different number on other systems.
# </p></dd>
function gawk::systime() {}

# <dd>
# </dd>
# <dt><code>and(</code><var>v1</var><code>,</code> <var>v2</var> [<code>,</code> &hellip;]<code>)</code></dt>
# <dd><p>Return the bitwise AND of the arguments. There must be at least two.
# </p>
# </dd>
function gawk::and() {}

# <dt><code>compl(<var>val</var>)</code></dt>
# <dd><p>Return the bitwise complement of <var>val</var>.
# </p>
# </dd>
function gawk::compl() {}

# <dt><code>lshift(<var>val</var>, <var>count</var>)</code></dt>
# <dd><p>Return the value of <var>val</var>, shifted left by <var>count</var> bits.
# </p>
# </dd>
function gawk::lshift() {}

# <dt><code>or(</code><var>v1</var><code>,</code> <var>v2</var> [<code>,</code> &hellip;]<code>)</code></dt>
# <dd><p>Return the bitwise OR of the arguments. There must be at least two.
# </p>
# </dd>
function gawk::or() {}

# <dt><code>rshift(<var>val</var>, <var>count</var>)</code></dt>
# <dd><p>Return the value of <var>val</var>, shifted right by <var>count</var> bits.
# </p>
# </dd>
function gawk::rshift() {}

# <dt><code>xor(</code><var>v1</var><code>,</code> <var>v2</var> [<code>,</code> &hellip;]<code>)</code></dt>
# <dd><p>Return the bitwise XOR of the arguments. There must be at least two.
# </p></dd>
function gawk::xor() {}

# <dd>
# </dd>
# <dt><code>isarray(<var>x</var>)</code></dt>
# <dd><p>Return a true value if <var>x</var> is an array. Otherwise, return false.
# </p>
# </dd>
function gawk::isarray() {}

# <dt><code>typeof(<var>x</var>)</code></dt>
# <dd><p>Return one of the following strings, depending upon the type of <var>x</var>:
# </p>
# <dl compact="compact">
# <dt><code>&quot;array&quot;</code></dt>
# <dd><p><var>x</var> is an array.
# </p>
# </dd>
# <dt><code>&quot;regexp&quot;</code></dt>
# <dd><p><var>x</var> is a strongly typed regexp (see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Strong-Regexp-Constants.html">Strongly Typed Regexp Constants</a>).
# </p>
# </dd>
# <dt><code>&quot;number&quot;</code></dt>
# <dd><p><var>x</var> is a number.
# </p>
# </dd>
# <dt><code>&quot;string&quot;</code></dt>
# <dd><p><var>x</var> is a string.
# </p>
# </dd>
# <dt><code>&quot;strnum&quot;</code></dt>
# <dd><p><var>x</var> is a number that started life as user input, such as a field or
# the result of calling <code>split()</code>. (I.e., <var>x</var> has the strnum
# attribute; see section <a href="https://www.gnu.org/software/gawk/manual/html_node/Variable-Typing.html">String Type versus Numeric Type</a>.)
# </p>
# </dd>
# <dt><code>&quot;unassigned&quot;</code></dt>
# <dd><p><var>x</var> is a scalar variable that has not been assigned a value yet.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">BEGIN {
# &nbsp;&nbsp;&nbsp;&nbsp;# creates a[1] but it has no assigned value
# &nbsp;&nbsp;&nbsp;&nbsp;a[1]
# &nbsp;&nbsp;&nbsp;&nbsp;print typeof(a[1])  # unassigned
# }
# </pre></div>
# 
# </dd>
# <dt><code>&quot;untyped&quot;</code></dt>
# <dd><p><var>x</var> has not yet been used yet at all; it can become a scalar or an
# array.  The typing could even conceivably differ from run to run of
# the same program! For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">BEGIN {
# &nbsp;&nbsp;&nbsp;&nbsp;print &quot;initially, typeof(v) = &quot;, typeof(v)
# 
# &nbsp;&nbsp;&nbsp;&nbsp;if (&quot;FOO&quot; in ENVIRON)
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;make_scalar(v)
# &nbsp;&nbsp;&nbsp;&nbsp;else
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;make_array(v)
# 
# &nbsp;&nbsp;&nbsp;&nbsp;print &quot;typeof(v) =&quot;, typeof(v)
# }
# 
# function make_scalar(p,    l) { l = p }
# 
# function make_array(p) { p[1] = 1 }
# </pre></div>
# 
# </dd>
# </dl>
# </dd>
function gawk::typeof() {}

# <dd>
# </dd>
# <dt><code>bindtextdomain(<var>directory</var></code> [<code>,</code> <var>domain</var>]<code>)</code></dt>
# <dd><p>Set the directory in which
# <code>gawk</code> will look for message translation files, in case they
# will not or cannot be placed in the &ldquo;standard&rdquo; locations
# (e.g., during testing).
# It returns the directory in which <var>domain</var> is &ldquo;bound.&rdquo;
# </p>
# <p>The default <var>domain</var> is the value of <code>TEXTDOMAIN</code>.
# If <var>directory</var> is the null string (<code>&quot;&quot;</code>), then
# <code>bindtextdomain()</code> returns the current binding for the
# given <var>domain</var>.
# </p>
# </dd>
function gawk::bindtextdomain() {}

# <dt><code>dcgettext(<var>string</var></code> [<code>,</code> <var>domain</var> [<code>,</code> <var>category</var>] ]<code>)</code></dt>
# <dd><p>Return the translation of <var>string</var> in
# text domain <var>domain</var> for locale category <var>category</var>.
# The default value for <var>domain</var> is the current value of <code>TEXTDOMAIN</code>.
# The default value for <var>category</var> is <code>&quot;LC_MESSAGES&quot;</code>.
# </p>
# </dd>
function gawk::dcgettext() {}

# <dt><code>dcngettext(<var>string1</var>, <var>string2</var>, <var>number</var></code> [<code>,</code> <var>domain</var> [<code>,</code> <var>category</var>] ]<code>)</code></dt>
# <dd><p>Return the plural form used for <var>number</var> of the
# translation of <var>string1</var> and <var>string2</var> in text domain
# <var>domain</var> for locale category <var>category</var>. <var>string1</var> is the
# English singular variant of a message, and <var>string2</var> is the English plural
# variant of the same message.
# The default value for <var>domain</var> is the current value of <code>TEXTDOMAIN</code>.
# The default value for <var>category</var> is <code>&quot;LC_MESSAGES&quot;</code>.
# </p></dd>
function gawk::dcngettext() {}
