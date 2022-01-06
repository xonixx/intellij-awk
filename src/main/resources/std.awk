

# <dt><code>asort(</code><var>source</var> [<code>,</code> <var>dest</var> [<code>,</code> <var>how</var> ] ]<code>) #</code></dt>
# <dt><code>asorti(</code><var>source</var> [<code>,</code> <var>dest</var> [<code>,</code> <var>how</var> ] ]<code>) #</code></dt>
# <dd><span id="index-asorti_0028_0029-function-_0028gawk_0029"></span>
# <span id="index-sort-array"></span>
# <span id="index-arrays-20"></span>
# <span id="index-asort_0028_0029-function-_0028gawk_0029"></span>
# <span id="index-sort-array-indices"></span>
# <p>These two functions are similar in behavior, so they are described
# together.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The following description ignores the third argument, <var>how</var>, as it
# requires understanding features that we have not discussed yet.  Thus,
# the discussion here is a deliberate simplification.  (We do provide all
# the details later on; see <a href="Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a> for the full story.)
# </p></blockquote>
# 
# <p>Both functions return the number of elements in the array <var>source</var>.
# For <code>asort()</code>, <code>gawk</code> sorts the values of <var>source</var>
# and replaces the indices of the sorted values of <var>source</var> with
# sequential integers starting with one.  If the optional array <var>dest</var>
# is specified, then <var>source</var> is duplicated into <var>dest</var>.  <var>dest</var>
# is then sorted, leaving the indices of <var>source</var> unchanged.
# </p>
# <span id="index-gawk-54"></span>
# <p>When comparing strings, <code>IGNORECASE</code> affects the sorting
# (see section <a href="Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a>).  If the
# <var>source</var> array contains subarrays as values (see section <a href="Arrays-of-Arrays.html">Arrays of Arrays</a>), they will come last, after all scalar values.
# Subarrays are <em>not</em> recursively sorted.
# </p>
# <p>For example, if the contents of <code>a</code> are as follows:
# </p>
# <div class="example">
# <pre class="example">a[&quot;last&quot;] = &quot;de&quot;
# a[&quot;first&quot;] = &quot;sac&quot;
# a[&quot;middle&quot;] = &quot;cul&quot;
# </pre></div>
# 
# <p>A call to <code>asort()</code>:
# </p>
# <div class="example">
# <pre class="example">asort(a)
# </pre></div>
# 
# <p>results in the following contents of <code>a</code>:
# </p>
# <div class="example">
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
# <div class="example">
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
function awk::asorti() {}

# <dt><code>gensub(<var>regexp</var>, <var>replacement</var>, <var>how</var></code> [<code>, <var>target</var></code>]<code>) #</code></dt>
# <dd><span id="index-gensub_0028_0029-function-_0028gawk_0029-1"></span>
# <span id="index-search-and-replace-in-strings"></span>
# <span id="index-substitute-in-string"></span>
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
# <div class="example">
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
# <div class="example">
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
function awk::gensub() {}

# <dt><code>gsub(<var>regexp</var>, <var>replacement</var></code> [<code>, <var>target</var></code>]<code>)</code></dt>
# <dd><span id="index-gsub_0028_0029-function-1"></span>
# <p>Search <var>target</var> for
# <em>all</em> of the longest, leftmost, <em>nonoverlapping</em> matching
# substrings it can find and replace them with <var>replacement</var>.
# The &lsquo;<samp>g</samp>&rsquo; in <code>gsub()</code> stands for
# &ldquo;global,&rdquo; which means replace everywhere.  For example:
# </p>
# <div class="example">
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
# <dd><span id="index-index_0028_0029-function"></span>
# <span id="index-search-for-substring"></span>
# <span id="index-find-substring-in-string"></span>
# <p>Search the string <var>in</var> for the first occurrence of the string
# <var>find</var>, and return the position in characters where that occurrence
# begins in the string <var>in</var>.  Consider the following example:
# </p>
# <div class="example">
# <pre class="example">$ <kbd>awk 'BEGIN { print index(&quot;peanut&quot;, &quot;an&quot;) }'</kbd>
# -| 3
# </pre></div>
# 
# <p>If <var>find</var> is not found, <code>index()</code> returns zero.
# </p>
# <span id="index-dark-corner-35"></span>
# <p>With BWK <code>awk</code> and <code>gawk</code>,
# it is a fatal error to use a regexp constant for <var>find</var>.
# Other implementations allow it, simply treating the regexp
# constant as an expression meaning &lsquo;<samp>$0 ~ /regexp/</samp>&rsquo;. (d.c.)
# </p>
# </dd>
function awk::index() {}

# <dt><code>length(</code>[<var>string</var>]<code>)</code></dt>
# <dd><span id="index-length_0028_0029-function"></span>
# <span id="index-string-3"></span>
# <span id="index-length-of-string"></span>
# <p>Return the number of characters in <var>string</var>.  If
# <var>string</var> is a number, the length of the digit string representing
# that number is returned.  For example, <code>length(&quot;abcde&quot;)</code> is five.  By
# contrast, <code>length(15 * 35)</code> works out to three. In this example,
# 15 * 35 = 525,
# and 525 is then converted to the string <code>&quot;525&quot;</code>, which has
# three characters.
# </p>
# <span id="index-length-of-input-record"></span>
# <span id="index-input-record_002c-length-of"></span>
# <p>If no argument is supplied, <code>length()</code> returns the length of <code>$0</code>.
# </p>
# <span id="index-portability-15"></span>
# <span id="index-POSIX-awk-25"></span>
# <blockquote>
# <p><b>NOTE:</b> In older versions of <code>awk</code>, the <code>length()</code> function could
# be called
# without any parentheses.  Doing so is considered poor practice,
# although the 2008 POSIX standard explicitly allows it, to
# support historical practice.  For programs to be maximally portable,
# always supply the parentheses.
# </p></blockquote>
# 
# <span id="index-dark-corner-36"></span>
# <p>If <code>length()</code> is called with a variable that has not been used,
# <code>gawk</code> forces the variable to be a scalar.  Other
# implementations of <code>awk</code> leave the variable without a type.
# (d.c.)
# Consider:
# </p>
# <div class="example">
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
# <span id="index-common-extensions-9"></span>
# <span id="index-extensions-10"></span>
# <span id="index-differences-in-awk-and-gawk-43"></span>
# <span id="index-number-of-array-elements"></span>
# <span id="index-arrays-21"></span>
# <p>With <code>gawk</code> and several other <code>awk</code> implementations, when given an
# array argument, the <code>length()</code> function returns the number of elements
# in the array. (c.e.)
# This is less useful than it might seem at first, as the
# array is not guaranteed to be indexed from one to the number of elements
# in it.
# If <samp>--lint</samp> is provided on the command line
# (see section <a href="Options.html">Command-Line Options</a>),
# <code>gawk</code> warns that passing an array argument is not portable.
# If <samp>--posix</samp> is supplied, using an array argument is a fatal error
# (see section <a href="Arrays.html">Arrays in <code>awk</code></a>).
# </p>
# </dd>
function awk::length() {}

# <dt><code>match(<var>string</var>, <var>regexp</var></code> [<code>, <var>array</var></code>]<code>)</code></dt>
# <dd><span id="index-match_0028_0029-function"></span>
# <span id="index-string-4"></span>
# <span id="index-match-regexp-in-string"></span>
# <p>Search <var>string</var> for the
# longest, leftmost substring matched by the regular expression
# <var>regexp</var> and return the character position (index)
# at which that substring begins (one, if it starts at the beginning of
# <var>string</var>).  If no match is found, return zero.
# </p>
# <p>The <var>regexp</var> argument may be either a regexp constant
# (<code>/</code>&hellip;<code>/</code>) or a string constant (<code>&quot;</code>&hellip;<code>&quot;</code>).
# In the latter case, the string is treated as a regexp to be matched.
# See section <a href="Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between the two forms, and the
# implications for writing your program correctly.
# </p>
# <p>The order of the first two arguments is the opposite of most other string
# functions that work with regular expressions, such as
# <code>sub()</code> and <code>gsub()</code>.  It might help to remember that
# for <code>match()</code>, the order is the same as for the &lsquo;<samp>~</samp>&rsquo; operator:
# &lsquo;<samp><var>string</var> ~ <var>regexp</var></samp>&rsquo;.
# </p>
# <span id="index-RSTART-variable-1"></span>
# <span id="index-RLENGTH-variable-1"></span>
# <span id="index-match_0028_0029-function-1"></span>
# <span id="index-match_0028_0029-function-2"></span>
# <span id="index-side-effects-11"></span>
# <p>The <code>match()</code> function sets the predefined variable <code>RSTART</code> to
# the index.  It also sets the predefined variable <code>RLENGTH</code> to the
# length in characters of the matched substring.  If no match is found,
# <code>RSTART</code> is set to zero, and <code>RLENGTH</code> to -1.
# </p>
# <p>For example:
# </p>
# <div class="example">
# <pre class="example">{
#     if ($1 == &quot;FIND&quot;)
#         regex = $2
#     else {
#         where = match($0, regex)
#         if (where != 0)
#             print &quot;Match of&quot;, regex, &quot;found at&quot;, where, &quot;in&quot;, $0
#        }
# }
# </pre></div>
# 
# <p>This program looks for lines that match the regular expression stored in
# the variable <code>regex</code>.  This regular expression can be changed.  If the
# first word on a line is &lsquo;<samp>FIND</samp>&rsquo;, <code>regex</code> is changed to be the
# second word on that line.  Therefore, if given:
# </p>
# <div class="example">
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
# <div class="example">
# <pre class="example">Match of ru+n found at 12 in My program runs
# Match of Melvin found at 1 in Melvin was here.
# </pre></div>
# 
# <span id="index-differences-in-awk-and-gawk-44"></span>
# <p>If <var>array</var> is present, it is cleared, and then the zeroth element
# of <var>array</var> is set to the entire portion of <var>string</var>
# matched by <var>regexp</var>.  If <var>regexp</var> contains parentheses,
# the integer-indexed elements of <var>array</var> are set to contain the
# portion of <var>string</var> matching the corresponding parenthesized
# subexpression.
# For example:
# </p>
# <div class="example">
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
# <div class="example">
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
# (see section <a href="Reference-to-Elements.html">Referring to an Array Element</a>).
# </p>
# <span id="index-troubleshooting-15"></span>
# <p>The <var>array</var> argument to <code>match()</code> is a
# <code>gawk</code> extension.  In compatibility mode
# (see section <a href="Options.html">Command-Line Options</a>),
# using a third argument is a fatal error.
# </p>
# </dd>
function awk::match() {}

# <dt><code>patsplit(<var>string</var>, <var>array</var></code> [<code>, <var>fieldpat</var></code> [<code>, <var>seps</var></code> ] ]<code>) #</code></dt>
# <dd><span id="index-patsplit_0028_0029-function-_0028gawk_0029"></span>
# <span id="index-split-string-into-array"></span>
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
# (see section <a href="Splitting-By-Content.html">Defining Fields by Content</a>).
# </p>
# <p>Before splitting the string, <code>patsplit()</code> deletes any previously existing
# elements in the arrays <var>array</var> and <var>seps</var>.
# </p>
# </dd>
function awk::patsplit() {}

# <dt><code>split(<var>string</var>, <var>array</var></code> [<code>, <var>fieldsep</var></code> [<code>, <var>seps</var></code> ] ]<code>)</code></dt>
# <dd><span id="index-split_0028_0029-function-1"></span>
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
# <div class="example">
# <pre class="example">split(&quot;cul-de-sac&quot;, a, &quot;-&quot;, seps)
# </pre></div>
# 
# <p><span id="index-strings-8"></span>
# splits the string <code>&quot;cul-de-sac&quot;</code> into three fields using &lsquo;<samp>-</samp>&rsquo; as the
# separator.  It sets the contents of the array <code>a</code> as follows:
# </p>
# <div class="example">
# <pre class="example">a[1] = &quot;cul&quot;
# a[2] = &quot;de&quot;
# a[3] = &quot;sac&quot;
# </pre></div>
# 
# <p>and sets the contents of the array <code>seps</code> as follows:
# </p>
# <div class="example">
# <pre class="example">seps[1] = &quot;-&quot;
# seps[2] = &quot;-&quot;
# </pre></div>
# 
# <p>The value returned by this call to <code>split()</code> is three.
# </p>
# <span id="index-differences-in-awk-and-gawk-45"></span>
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
# <span id="index-dark-corner-37"></span>
# <p>Modern implementations of <code>awk</code>, including <code>gawk</code>, allow
# the third argument to be a regexp constant (<code>/</code>&hellip;<code>/</code><!-- /@w -->)
# as well as a string.  (d.c.)
# The POSIX standard allows this as well.
# See section <a href="Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between using a string constant or a regexp constant,
# and the implications for writing your program correctly.
# </p>
# <p>Before splitting the string, <code>split()</code> deletes any previously existing
# elements in the arrays <var>array</var> and <var>seps</var>.
# </p>
# <p>If <var>string</var> is null, the array has no elements. (So this is a portable
# way to delete an entire array with one statement.
# See section <a href="Delete.html">The <code>delete</code> Statement</a>.)
# </p>
# <p>If <var>string</var> does not match <var>fieldsep</var> at all (but is not null),
# <var>array</var> has one element only. The value of that element is the original
# <var>string</var>.
# </p>
# <span id="index-POSIX-mode-10"></span>
# <p>In POSIX mode (see section <a href="Options.html">Command-Line Options</a>), the fourth argument is not allowed.
# </p>
# </dd>
function awk::split() {}

# <dt><code>sprintf(<var>format</var>, <var>expression1</var>, &hellip;)</code></dt>
# <dd><span id="index-sprintf_0028_0029-function-1"></span>
# <span id="index-formatting-1"></span>
# <p>Return (without printing) the string that <code>printf</code> would
# have printed out with the same arguments
# (see section <a href="Printf.html">Using <code>printf</code> Statements for Fancier Printing</a>).
# For example:
# </p>
# <div class="example">
# <pre class="example">pival = sprintf(&quot;pi = %.2f (approx.)&quot;, 22/7)
# </pre></div>
# 
# <p>assigns the string &lsquo;<samp>pi&nbsp;=&nbsp;3.14&nbsp;(approx.)</samp>&rsquo;<!-- /@w --> to the variable <code>pival</code>.
# </p>
# <span id="index-strtonum_0028_0029-function-_0028gawk_0029"></span>
# <span id="index-converting-3"></span>
# </dd>
function awk::sprintf() {}

# <dt><code>strtonum(<var>str</var>) #</code></dt>
# <dd><p>Examine <var>str</var> and return its numeric value.  If <var>str</var>
# begins with a leading &lsquo;<samp>0</samp>&rsquo;, <code>strtonum()</code> assumes that <var>str</var>
# is an octal number.  If <var>str</var> begins with a leading &lsquo;<samp>0x</samp>&rsquo; or
# &lsquo;<samp>0X</samp>&rsquo;, <code>strtonum()</code> assumes that <var>str</var> is a hexadecimal number.
# For example:
# </p>
# <div class="example">
# <pre class="example">$ <kbd>echo 0x11 |</kbd>
# &gt; <kbd>gawk '{ printf &quot;%d\n&quot;, strtonum($1) }'</kbd>
# -| 17
# </pre></div>
# 
# <p>Using the <code>strtonum()</code> function is <em>not</em> the same as adding zero
# to a string value; the automatic coercion of strings to numbers
# works only for decimal data, not for octal or hexadecimal.<a id="DOCF47" href="#FOOT47"><sup>47</sup></a>
# </p>
# <p>Note also that <code>strtonum()</code> uses the current locale&rsquo;s decimal point
# for recognizing numbers (see section <a href="Locales.html">Where You Are Makes a Difference</a>).
# </p>
# </dd>
function awk::strtonum() {}

# <dt><code>sub(<var>regexp</var>, <var>replacement</var></code> [<code>, <var>target</var></code>]<code>)</code></dt>
# <dd><span id="index-sub_0028_0029-function-1"></span>
# <span id="index-replace-in-string"></span>
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
# See section <a href="Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between the two forms, and the
# implications for writing your program correctly.
# </p>
# <p>This function is peculiar because <var>target</var> is not simply
# used to compute a value, and not just any expression will do&mdash;it
# must be a variable, field, or array element so that <code>sub()</code> can
# store a modified value there.  If this argument is omitted, then the
# default is to use and alter <code>$0</code>.<a id="DOCF48" href="#FOOT48"><sup>48</sup></a>
# For example:
# </p>
# <div class="example">
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
# <div class="example">
# <pre class="example">{ sub(/candidate/, &quot;&amp; and his wife&quot;); print }
# </pre></div>
# 
# <p>changes the first occurrence of &lsquo;<samp>candidate</samp>&rsquo; to &lsquo;<samp>candidate
# and his wife</samp>&rsquo; on each input line.
# Here is another example:
# </p>
# <div class="example">
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
# (see section <a href="Leftmost-Longest.html">How Much Text Matches?</a>).
# </p>
# <p>The effect of this special character (&lsquo;<samp>&amp;</samp>&rsquo;) can be turned off by putting a
# backslash before it in the string.  As usual, to insert one backslash in
# the string, you must write two backslashes.  Therefore, write &lsquo;<samp>\\&amp;</samp>&rsquo;
# in a string constant to include a literal &lsquo;<samp>&amp;</samp>&rsquo; in the replacement.
# For example, the following shows how to replace the first &lsquo;<samp>|</samp>&rsquo; on each line with
# an &lsquo;<samp>&amp;</samp>&rsquo;:
# </p>
# <div class="example">
# <pre class="example">{ sub(/\|/, &quot;\\&amp;&quot;); print }
# </pre></div>
# 
# <span id="index-sub_0028_0029-function-2"></span>
# <span id="index-gsub_0028_0029-function-2"></span>
# <span id="index-side-effects-12"></span>
# <span id="index-side-effects-13"></span>
# <p>As mentioned, the third argument to <code>sub()</code> must
# be a variable, field, or array element.
# Some versions of <code>awk</code> allow the third argument to
# be an expression that is not an lvalue.  In such a case, <code>sub()</code>
# still searches for the pattern and returns zero or one, but the result of
# the substitution (if any) is thrown away because there is no place
# to put it.  Such versions of <code>awk</code> accept expressions
# like the following:
# </p>
# <div class="example">
# <pre class="example">sub(/USA/, &quot;United States&quot;, &quot;the USA and Canada&quot;)
# </pre></div>
# 
# <p><span id="index-troubleshooting-16"></span>
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
# <dd><span id="index-substr_0028_0029-function"></span>
# <span id="index-substring"></span>
# <p>Return a <var>length</var>-character-long substring of <var>string</var>,
# starting at character number <var>start</var>.  The first character of a
# string is character number one.<a id="DOCF49" href="#FOOT49"><sup>49</sup></a>
# For example, <code>substr(&quot;washington&quot;, 5, 3)</code> returns <code>&quot;ing&quot;</code>.
# </p>
# <p>If <var>length</var> is not present, <code>substr()</code> returns the whole suffix of
# <var>string</var> that begins at character number <var>start</var>.  For example,
# <code>substr(&quot;washington&quot;, 5)</code> returns <code>&quot;ington&quot;</code>.  The whole
# suffix is also returned
# if <var>length</var> is greater than the number of characters remaining
# in the string, counting from character <var>start</var>.
# </p>
# <span id="index-Brian-Kernighan_0027s-awk-12"></span>
# <p>If <var>start</var> is less than one, <code>substr()</code> treats it as
# if it was one. (POSIX doesn&rsquo;t specify what to do in this case:
# BWK <code>awk</code> acts this way, and therefore <code>gawk</code>
# does too.)
# If <var>start</var> is greater than the number of characters
# in the string, <code>substr()</code> returns the null string.
# Similarly, if <var>length</var> is present but less than or equal to zero,
# the null string is returned.
# </p>
# <span id="index-troubleshooting-17"></span>
# <p>The string returned by <code>substr()</code> <em>cannot</em> be
# assigned.  Thus, it is a mistake to attempt to change a portion of
# a string, as shown in the following example:
# </p>
# <div class="example">
# <pre class="example">string = &quot;abcdef&quot;
# # try to get &quot;abCDEf&quot;, won't work
# substr(string, 3, 3) = &quot;CDE&quot;
# </pre></div>
# 
# <p>It is also a mistake to use <code>substr()</code> as the third argument
# of <code>sub()</code> or <code>gsub()</code>:
# </p>
# <div class="example">
# <pre class="example">gsub(/xyz/, &quot;pdq&quot;, substr($0, 5, 20))  # WRONG
# </pre></div>
# 
# <span id="index-portability-16"></span>
# <p>(Some commercial versions of <code>awk</code> treat
# <code>substr()</code> as assignable, but doing so is not portable.)
# </p>
# <p>If you need to replace bits and pieces of a string, combine <code>substr()</code>
# with string concatenation, in the following manner:
# </p>
# <div class="example">
# <pre class="example">string = &quot;abcdef&quot;
# &hellip;
# string = substr(string, 1, 2) &quot;CDE&quot; substr(string, 6)
# </pre></div>
# 
# <span id="index-case-sensitivity-5"></span>
# <span id="index-strings-9"></span>
# </dd>
function awk::substr() {}

# <dt><code>tolower(<var>string</var>)</code></dt>
# <dd><span id="index-tolower_0028_0029-function"></span>
# <span id="index-converting-4"></span>
# <p>Return a copy of <var>string</var>, with each uppercase character
# in the string replaced with its corresponding lowercase character.
# Nonalphabetic characters are left unchanged.  For example,
# <code>tolower(&quot;MiXeD cAsE 123&quot;)</code> returns <code>&quot;mixed case 123&quot;</code>.
# </p>
# </dd>
function awk::tolower() {}
