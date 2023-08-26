BEGIN {

# <dt><code>BINMODE</code></dt>
# <dd><p>On non-POSIX systems, this variable specifies use of binary mode
# for all I/O.  Numeric values of one, two, or three specify that input
# files, output files, or all files, respectively, should use binary I/O.
# A numeric value less than zero is treated as zero, and a numeric value
# greater than three is treated as three.  Alternatively, string values
# of <code>&quot;r&quot;</code> or <code>&quot;w&quot;</code> specify that input files and output files,
# respectively, should use binary I/O.  A string value of <code>&quot;rw&quot;</code> or
# <code>&quot;wr&quot;</code> indicates that all files should use binary I/O.  Any other
# string value is treated the same as <code>&quot;rw&quot;</code>, but causes <code>gawk</code>
# to generate a warning message.  <code>BINMODE</code> is described in more
# detail in <a href="https://www.gnu.org/software/gawk/manual/html_node/PC-Using.html">Using <code>gawk</code> on PC Operating Systems</a>.  <code>mawk</code> (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Other-Versions.html">Other Freely Available <code>awk</code> Implementations</a>)
# also supports this variable, but only using numeric values.
# </p>
# </dd>
gawk::BINMODE = ""

# <dt><code>CONVFMT</code></dt>
# <dd><p>A string that controls the conversion of numbers to
# strings (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Conversion.html">Conversion of Strings and Numbers</a>).
# It works by being passed, in effect, as the first argument to the
# <code>sprintf()</code> function
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html">String-Manipulation Functions</a>).
# Its default value is <code>&quot;%.6g&quot;</code>.
# <code>CONVFMT</code> was introduced by the POSIX standard.
# </p>
# </dd>
awk::CONVFMT = ""

# <dt><code>FIELDWIDTHS</code></dt>
# <dd><p>A space-separated list of columns that tells <code>gawk</code>
# how to split input with fixed columnar boundaries.
# Starting in version 4.2, each field width may optionally be
# preceded by a colon-separated value specifying the number of characters to skip
# before the field starts.
# Assigning a value to <code>FIELDWIDTHS</code>
# overrides the use of <code>FS</code> and <code>FPAT</code> for field splitting.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Constant-Size.html">Reading Fixed-Width Data</a> for more information.
# </p>
# </dd>
gawk::FIELDWIDTHS = ""

# <dt><code>FPAT</code></dt>
# <dd><p>A regular expression (as a string) that tells <code>gawk</code>
# to create the fields based on text that matches the regular expression.
# Assigning a value to <code>FPAT</code>
# overrides the use of <code>FS</code> and <code>FIELDWIDTHS</code> for field splitting.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Splitting-By-Content.html">Defining Fields by Content</a> for more information.
# </p>
# </dd>
gawk::FPAT = ""

# <dt><code>FS</code></dt>
# <dd><p>The input field separator (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Field-Separators.html">Specifying How Fields Are Separated</a>).
# The value is a single-character string or a multicharacter regular
# expression that matches the separations between fields in an input
# record.  If the value is the null string (<code>&quot;&quot;</code>), then each
# character in the record becomes a separate field.
# (This behavior is a <code>gawk</code> extension. POSIX <code>awk</code> does not
# specify the behavior when <code>FS</code> is the null string.
# Nonetheless, some other versions of <code>awk</code> also treat
# <code>&quot;&quot;</code> specially.)
# </p>
# <p>The default value is <code>&quot;&nbsp;&quot;</code><!-- /@w -->, a string consisting of a single
# space.  As a special exception, this value means that any sequence of
# spaces, TABs, and/or newlines is a single separator.  It also causes
# spaces, TABs, and newlines at the beginning and end of a record to
# be ignored.
# </p>
# <p>You can set the value of <code>FS</code> on the command line using the
# <samp>-F</samp> option:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">awk -F, '<var>program</var>' <var>input-files</var>
# </pre></div>
# 
# <p>If <code>gawk</code> is using <code>FIELDWIDTHS</code> or <code>FPAT</code>
# for field splitting,
# assigning a value to <code>FS</code> causes <code>gawk</code> to return to
# the normal, <code>FS</code>-based field splitting. An easy way to do this
# is to simply say &lsquo;<samp>FS = FS</samp>&rsquo;, perhaps with an explanatory comment.
# </p>
# </dd>
awk::FS = ""

# <dt><code>IGNORECASE</code></dt>
# <dd><p>If <code>IGNORECASE</code> is nonzero or non-null, then all string comparisons
# and all regular expression matching are case-independent.
# This applies to
# regexp matching with &lsquo;<samp>~</samp>&rsquo; and &lsquo;<samp>!~</samp>&rsquo;,
# the <code>gensub()</code>, <code>gsub()</code>, <code>index()</code>, <code>match()</code>,
# <code>patsplit()</code>, <code>split()</code>, and <code>sub()</code> functions,
# record termination with <code>RS</code>, and field splitting with
# <code>FS</code> and <code>FPAT</code>.
# However, the value of <code>IGNORECASE</code> does <em>not</em> affect array subscripting
# and it does not affect field splitting when using a single-character
# field separator.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Case_002dsensitivity.html">Case Sensitivity in Matching</a>.
# </p>
# </dd>
gawk::IGNORECASE = ""

# <dt><code>LINT</code></dt>
# <dd><p>When this variable is true (nonzero or non-null), <code>gawk</code>
# behaves as if the <samp>--lint</samp> command-line option is in effect
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>).
# With a value of <code>&quot;fatal&quot;</code>, lint warnings become fatal errors.
# With a value of <code>&quot;invalid&quot;</code>, only warnings about things that are
# actually invalid are issued. (This is not fully implemented yet.)
# Any other true value prints nonfatal warnings.
# Assigning a false value to <code>LINT</code> turns off the lint warnings.
# </p>
# <p>This variable is a <code>gawk</code> extension.  It is not special
# in other <code>awk</code> implementations.  Unlike with the other special variables,
# changing <code>LINT</code> does affect the production of lint warnings,
# even if <code>gawk</code> is in compatibility mode.  Much as
# the <samp>--lint</samp> and <samp>--traditional</samp> options independently
# control different aspects of <code>gawk</code>&rsquo;s behavior, the control
# of lint warnings during program execution is independent of the flavor
# of <code>awk</code> being executed.
# </p>
# </dd>
gawk::LINT = ""

# <dt><code>OFMT</code></dt>
# <dd><p>A string that controls conversion of numbers to
# strings (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Conversion.html">Conversion of Strings and Numbers</a>) for
# printing with the <code>print</code> statement.  It works by being passed
# as the first argument to the <code>sprintf()</code> function
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html">String-Manipulation Functions</a>).
# Its default value is <code>&quot;%.6g&quot;</code>.  Earlier versions of <code>awk</code>
# used <code>OFMT</code> to specify the format for converting numbers to
# strings in general expressions; this is now done by <code>CONVFMT</code>.
# </p>
# </dd>
awk::OFMT = ""

# <dt><code>OFS</code></dt>
# <dd><p>The output field separator (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Output-Separators.html">Output Separators</a>).  It is
# output between the fields printed by a <code>print</code> statement.  Its
# default value is <code>&quot;&nbsp;&quot;</code><!-- /@w -->, a string consisting of a single space.
# </p>
# </dd>
awk::OFS = ""

# <dt><code>ORS</code></dt>
# <dd><p>The output record separator.  It is output at the end of every
# <code>print</code> statement.  Its default value is <code>&quot;\n&quot;</code>, the newline
# character.  (See <a href="https://www.gnu.org/software/gawk/manual/html_node/Output-Separators.html">Output Separators</a>.)
# </p>
# </dd>
awk::ORS = ""

# <dt><code>PREC</code></dt>
# <dd><p>The working precision of arbitrary-precision floating-point numbers,
# 53 bits by default (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Setting-precision.html">Setting the Precision</a>).
# </p>
# </dd>
gawk::PREC = ""

# <dt><code>ROUNDMODE</code></dt>
# <dd><p>The rounding mode to use for arbitrary-precision arithmetic on
# numbers, by default <code>&quot;N&quot;</code> (<code>roundTiesToEven</code> in
# the IEEE 754 standard; see <a href="https://www.gnu.org/software/gawk/manual/html_node/Setting-the-rounding-mode.html">Setting the Rounding Mode</a>).
# </p>
# </dd>
gawk::ROUNDMODE = ""

# <dt><code>RS</code></dt>
# <dd><p>The input record separator.  Its default value is a string
# containing a single newline character, which means that an input record
# consists of a single line of text.
# It can also be the null string, in which case records are separated by
# runs of blank lines.
# If it is a regexp, records are separated by
# matches of the regexp in the input text.
# (See <a href="https://www.gnu.org/software/gawk/manual/html_node/Records.html">How Input Is Split into Records</a>.)
# </p>
# <p>The ability for <code>RS</code> to be a regular expression
# is a <code>gawk</code> extension.
# In most other <code>awk</code> implementations,
# or if <code>gawk</code> is in compatibility mode
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>),
# just the first character of <code>RS</code>&rsquo;s value is used.
# </p>
# </dd>
awk::RS = ""

# <dt><code>SUBSEP</code></dt>
# <dd><p>The subscript separator.  It has the default value of
# <code>&quot;\034&quot;</code> and is used to separate the parts of the indices of a
# multidimensional array.  Thus, the expression &lsquo;<samp>foo[&quot;A&quot;,&nbsp;&quot;B&quot;]<!-- /@w --></samp>&rsquo;
# really accesses <code>foo[&quot;A\034B&quot;]</code>
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Multidimensional.html">Multidimensional Arrays</a>).
# </p>
# </dd>
awk::SUBSEP = ""

# <dt><code>TEXTDOMAIN</code></dt>
# <dd><p>Used for internationalization of programs at the
# <code>awk</code> level.  It sets the default text domain for specially
# marked string constants in the source text, as well as for the
# <code>dcgettext()</code>, <code>dcngettext()</code>, and <code>bindtextdomain()</code> functions
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Internationalization.html">Internationalization with <code>gawk</code></a>).
# The default value of <code>TEXTDOMAIN</code> is <code>&quot;messages&quot;</code>.
# </p></dd>
gawk::TEXTDOMAIN = ""

# <dt><code>ARGC</code>, <code>ARGV</code></dt>
# <dd><p>The command-line arguments available to <code>awk</code> programs are stored in
# an array called <code>ARGV</code>.  <code>ARGC</code> is the number of command-line
# arguments present.  See <a href="https://www.gnu.org/software/gawk/manual/html_node/Other-Arguments.html">Other Command-Line Arguments</a>.
# Unlike most <code>awk</code> arrays,
# <code>ARGV</code> is indexed from 0 to <code>ARGC</code> - 1.
# In the following example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>awk 'BEGIN {</kbd>
# &gt;         <kbd>for (i = 0; i &lt; ARGC; i++)</kbd>
# &gt;             <kbd>print ARGV[i]</kbd>
# &gt;      <kbd>}' inventory-shipped mail-list</kbd>
# -| awk
# -| inventory-shipped
# -| mail-list
# </pre></div>
# 
# <p><code>ARGV[0]</code> contains &lsquo;<samp>awk</samp>&rsquo;, <code>ARGV[1]</code>
# contains &lsquo;<samp>inventory-shipped</samp>&rsquo;, and <code>ARGV[2]</code> contains
# &lsquo;<samp>mail-list</samp>&rsquo;.  The value of <code>ARGC</code> is three, one more than the
# index of the last element in <code>ARGV</code>, because the elements are numbered
# from zero.
# </p>
# <p>The names <code>ARGC</code> and <code>ARGV</code>, as well as the convention of indexing
# the array from 0 to <code>ARGC</code> - 1, are derived from the C language&rsquo;s
# method of accessing command-line arguments.
# </p>
# <p>The value of <code>ARGV[0]</code> can vary from system to system.
# Also, you should note that the program text is <em>not</em> included in
# <code>ARGV</code>, nor are any of <code>awk</code>&rsquo;s command-line options.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/ARGC-and-ARGV.html">Using <code>ARGC</code> and <code>ARGV</code></a> for information
# about how <code>awk</code> uses these variables.
# (d.c.)
# </p>
# </dd>
awk::ARGV = ""

# <dt><code>ARGC</code>, <code>ARGV</code></dt>
# <dd><p>The command-line arguments available to <code>awk</code> programs are stored in
# an array called <code>ARGV</code>.  <code>ARGC</code> is the number of command-line
# arguments present.  See <a href="https://www.gnu.org/software/gawk/manual/html_node/Other-Arguments.html">Other Command-Line Arguments</a>.
# Unlike most <code>awk</code> arrays,
# <code>ARGV</code> is indexed from 0 to <code>ARGC</code> - 1.
# In the following example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>awk 'BEGIN {</kbd>
# &gt;         <kbd>for (i = 0; i &lt; ARGC; i++)</kbd>
# &gt;             <kbd>print ARGV[i]</kbd>
# &gt;      <kbd>}' inventory-shipped mail-list</kbd>
# -| awk
# -| inventory-shipped
# -| mail-list
# </pre></div>
# 
# <p><code>ARGV[0]</code> contains &lsquo;<samp>awk</samp>&rsquo;, <code>ARGV[1]</code>
# contains &lsquo;<samp>inventory-shipped</samp>&rsquo;, and <code>ARGV[2]</code> contains
# &lsquo;<samp>mail-list</samp>&rsquo;.  The value of <code>ARGC</code> is three, one more than the
# index of the last element in <code>ARGV</code>, because the elements are numbered
# from zero.
# </p>
# <p>The names <code>ARGC</code> and <code>ARGV</code>, as well as the convention of indexing
# the array from 0 to <code>ARGC</code> - 1, are derived from the C language&rsquo;s
# method of accessing command-line arguments.
# </p>
# <p>The value of <code>ARGV[0]</code> can vary from system to system.
# Also, you should note that the program text is <em>not</em> included in
# <code>ARGV</code>, nor are any of <code>awk</code>&rsquo;s command-line options.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/ARGC-and-ARGV.html">Using <code>ARGC</code> and <code>ARGV</code></a> for information
# about how <code>awk</code> uses these variables.
# (d.c.)
# </p>
# </dd>
awk::ARGC = ""

# <dt><code>ARGIND</code></dt>
# <dd><p>The index in <code>ARGV</code> of the current file being processed.
# Every time <code>gawk</code> opens a new data file for processing, it sets
# <code>ARGIND</code> to the index in <code>ARGV</code> of the file name.
# When <code>gawk</code> is processing the input files,
# &lsquo;<samp>FILENAME == ARGV[ARGIND]</samp>&rsquo; is always true.
# </p>
# <p>This variable is useful in file processing; it allows you to tell how far
# along you are in the list of data files as well as to distinguish between
# successive instances of the same file name on the command line.
# </p>
# <p>While you can change the value of <code>ARGIND</code> within your <code>awk</code>
# program, <code>gawk</code> automatically sets it to a new value when it
# opens the next file.
# </p>
# </dd>
gawk::ARGIND = ""

# <dt><code>ENVIRON</code></dt>
# <dd><p>An associative array containing the values of the environment.  The array
# indices are the environment variable names; the elements are the values of
# the particular environment variables.  For example,
# <code>ENVIRON[&quot;HOME&quot;]</code> might be <code>/home/arnold</code>.
# </p>
# <p>For POSIX <code>awk</code>, changing this array does not affect the
# environment passed on to any programs that <code>awk</code> may spawn via
# redirection or the <code>system()</code> function.
# </p>
# <p>However, beginning with version 4.2, if not in POSIX
# compatibility mode, <code>gawk</code> does update its own environment when
# <code>ENVIRON</code> is changed, thus changing the environment seen by programs
# that it creates.  You should therefore be especially careful if you
# modify <code>ENVIRON[&quot;PATH&quot;]</code>, which is the search path for finding
# executable programs.
# </p>
# <p>This can also affect the running <code>gawk</code> program, since some of the
# built-in functions may pay attention to certain environment variables.
# The most notable instance of this is <code>mktime()</code> (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html">Time Functions</a>), which pays attention the value of the <code>TZ</code> environment
# variable on many systems.
# </p>
# <p>Some operating systems may not have environment variables.
# On such systems, the <code>ENVIRON</code> array is empty (except for
# <code>ENVIRON[&quot;AWKPATH&quot;]</code><!-- /@w --> and
# <code>ENVIRON[&quot;AWKLIBPATH&quot;]</code><!-- /@w -->;
# see <a href="https://www.gnu.org/software/gawk/manual/html_node/AWKPATH-Variable.html">The <code>AWKPATH</code> Environment Variable</a> and
# see <a href="https://www.gnu.org/software/gawk/manual/html_node/AWKLIBPATH-Variable.html">The <code>AWKLIBPATH</code> Environment Variable</a>).
# </p>
# </dd>
awk::ENVIRON = ""

# <dt><code>ERRNO</code></dt>
# <dd><p>If a system error occurs during a redirection for <code>getline</code>, during
# a read for <code>getline</code>, or during a <code>close()</code> operation, then
# <code>ERRNO</code> contains a string describing the error.
# </p>
# <p>In addition, <code>gawk</code> clears <code>ERRNO</code> before opening each
# command-line input file. This enables checking if the file is readable
# inside a <code>BEGINFILE</code> pattern (see <a href="https://www.gnu.org/software/gawk/manual/html_node/BEGINFILE_002fENDFILE.html">The <code>BEGINFILE</code> and <code>ENDFILE</code> Special Patterns</a>).
# </p>
# <p>Otherwise, <code>ERRNO</code> works similarly to the C variable <code>errno</code>.
# Except for the case just mentioned, <code>gawk</code> <em>never</em> clears
# it (sets it to zero or <code>&quot;&quot;</code>).  Thus, you should only expect its
# value to be meaningful when an I/O operation returns a failure value,
# such as <code>getline</code> returning -1.  You are, of course, free
# to clear it yourself before doing an I/O operation.
# </p>
# <p>If the value of <code>ERRNO</code> corresponds to a system error in the C
# <code>errno</code> variable, then <code>PROCINFO[&quot;errno&quot;]</code> will be set to the value
# of <code>errno</code>.  For non-system errors, <code>PROCINFO[&quot;errno&quot;]</code> will
# be zero.
# </p>
# </dd>
gawk::ERRNO = ""

# <dt><code>FILENAME</code></dt>
# <dd><p>The name of the current input file.  When no data files are listed
# on the command line, <code>awk</code> reads from the standard input and
# <code>FILENAME</code> is set to <code>&quot;-&quot;</code>.  <code>FILENAME</code> changes each
# time a new file is read (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Reading-Files.html">Reading Input Files</a>).  Inside a <code>BEGIN</code>
# rule, the value of <code>FILENAME</code> is <code>&quot;&quot;</code>, because there are no input
# files being processed yet. (d.c.) Note, though,
# that using <code>getline</code> (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Getline.html">Explicit Input with <code>getline</code></a>) inside a <code>BEGIN</code> rule
# can give <code>FILENAME</code> a value.
# </p>
# </dd>
awk::FILENAME = ""

# <dt><code>FNR</code></dt>
# <dd><p>The current record number in the current file.  <code>awk</code> increments
# <code>FNR</code> each time it reads a new record (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Records.html">How Input Is Split into Records</a>).
# <code>awk</code> resets <code>FNR</code> to zero each time it starts a new
# input file.
# </p>
# </dd>
awk::FNR = ""

# <dt><code>NF</code></dt>
# <dd><p>The number of fields in the current input record.
# <code>NF</code> is set each time a new record is read, when a new field is
# created, or when <code>$0</code> changes (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Fields.html">Examining Fields</a>).
# </p>
# <p>Unlike most of the variables described in this subsection,
# assigning a value to <code>NF</code> has the potential to affect
# <code>awk</code>&rsquo;s internal workings.  In particular, assignments
# to <code>NF</code> can be used to create fields in or remove fields from the
# current record. See <a href="https://www.gnu.org/software/gawk/manual/html_node/Changing-Fields.html">Changing the Contents of a Field</a>.
# </p>
# </dd>
awk::NF = ""

# <dt><code>FUNCTAB</code></dt>
# <dd><p>An array whose indices and corresponding values are the names of all
# the built-in, user-defined, and extension functions in the program.
# </p>
# <blockquote>
# <p><b>NOTE:</b> Attempting to use the <code>delete</code> statement with the <code>FUNCTAB</code>
# array causes a fatal error.  Any attempt to assign to an element of
# <code>FUNCTAB</code> also causes a fatal error.
# </p></blockquote>
# 
# </dd>
gawk::FUNCTAB = ""

# <dt><code>NR</code></dt>
# <dd><p>The number of input records <code>awk</code> has processed since
# the beginning of the program&rsquo;s execution
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Records.html">How Input Is Split into Records</a>).
# <code>awk</code> increments <code>NR</code> each time it reads a new record.
# </p>
# </dd>
awk::NR = ""

# <dt><code>PROCINFO</code></dt>
# <dd><p>The elements of this array provide access to information about the
# running <code>awk</code> program.
# The following elements (listed alphabetically)
# are guaranteed to be available:
# </p>
# <dl compact="compact">
# <dt><code>PROCINFO[&quot;argv&quot;]</code></dt>
# <dd><p>The <code>PROCINFO[&quot;argv&quot;]</code> array contains all of the command-line arguments
# (after glob expansion and redirection processing on platforms where that must
# be done manually by the program) with subscripts ranging from 0 through
# <code>argc</code> - 1.  For example, <code>PROCINFO[&quot;argv&quot;][0]</code> will contain
# the name by which <code>gawk</code> was invoked.  Here is an example of how this
# feature may be used:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">gawk '
# BEGIN {
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i &lt; length(PROCINFO[&quot;argv&quot;]); i++)
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print i, PROCINFO[&quot;argv&quot;][i]
# }'
# </pre></div>
# 
# <p>Please note that this differs from the standard <code>ARGV</code> array which does
# not include command-line arguments that have already been processed by
# <code>gawk</code> (see <a href="https://www.gnu.org/software/gawk/manual/html_node/ARGC-and-ARGV.html">Using <code>ARGC</code> and <code>ARGV</code></a>).
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;egid&quot;]</code></dt>
# <dd><p>The value of the <code>getegid()</code> system call.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;errno&quot;]</code></dt>
# <dd><p>The value of the C <code>errno</code> variable when <code>ERRNO</code> is set to
# the associated error message.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;euid&quot;]</code></dt>
# <dd><p>The value of the <code>geteuid()</code> system call.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;FS&quot;]</code></dt>
# <dd><p>This is
# <code>&quot;FS&quot;</code> if field splitting with <code>FS</code> is in effect,
# <code>&quot;FIELDWIDTHS&quot;</code> if field splitting with <code>FIELDWIDTHS</code> is in effect,
# <code>&quot;FPAT&quot;</code> if field matching with <code>FPAT</code> is in effect,
# or <code>&quot;API&quot;</code> if field splitting is controlled by an API input parser.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;gid&quot;]</code></dt>
# <dd><p>The value of the <code>getgid()</code> system call.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;identifiers&quot;]</code></dt>
# <dd><p>A subarray, indexed by the names of all identifiers used in the text of
# the <code>awk</code> program.  An <em>identifier</em> is simply the name of a variable
# (be it scalar or array), built-in function, user-defined function, or
# extension function.  For each identifier, the value of the element is
# one of the following:
# </p>
# <dl compact="compact">
# <dt><code>&quot;array&quot;</code></dt>
# <dd><p>The identifier is an array.
# </p>
# </dd>
# <dt><code>&quot;builtin&quot;</code></dt>
# <dd><p>The identifier is a built-in function.
# </p>
# </dd>
# <dt><code>&quot;extension&quot;</code></dt>
# <dd><p>The identifier is an extension function loaded via
# <code>@load</code> or <samp>-l</samp>.
# </p>
# </dd>
# <dt><code>&quot;scalar&quot;</code></dt>
# <dd><p>The identifier is a scalar.
# </p>
# </dd>
# <dt><code>&quot;untyped&quot;</code></dt>
# <dd><p>The identifier is untyped (could be used as a scalar or an array;
# <code>gawk</code> doesn&rsquo;t know yet).
# </p>
# </dd>
# <dt><code>&quot;user&quot;</code></dt>
# <dd><p>The identifier is a user-defined function.
# </p></dd>
# </dl>
# 
# <p>The values indicate what <code>gawk</code> knows about the identifiers
# after it has finished parsing the program; they are <em>not</em> updated
# while the program runs.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;platform&quot;]</code></dt>
# <dd>
# <p>This element gives a string indicating the platform for which
# <code>gawk</code> was compiled. The value will be one of the following:
# </p>
# <dl compact="compact">
# <dt><code>&quot;mingw&quot;</code></dt>
# <dd><p>Microsoft Windows, using MinGW.
# </p>
# </dd>
# <dt><code>&quot;os390&quot;</code></dt>
# <dd><p>OS/390.
# </p>
# </dd>
# <dt><code>&quot;posix&quot;</code></dt>
# <dd><p>GNU/Linux, Cygwin, Mac OS X, and legacy Unix systems.
# </p>
# </dd>
# <dt><code>&quot;vms&quot;</code></dt>
# <dd><p>OpenVMS or Vax/VMS.
# </p></dd>
# </dl>
# 
# </dd>
# <dt><code>PROCINFO[&quot;pgrpid&quot;]</code></dt>
# <dd><p>The process group ID of the current process.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;pid&quot;]</code></dt>
# <dd><p>The process ID of the current process.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;ppid&quot;]</code></dt>
# <dd><p>The parent process ID of the current process.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;strftime&quot;]</code></dt>
# <dd><p>The default time format string for <code>strftime()</code>.
# Assigning a new value to this element changes the default.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Time-Functions.html">Time Functions</a>.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;uid&quot;]</code></dt>
# <dd><p>The value of the <code>getuid()</code> system call.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;version&quot;]</code></dt>
# <dd>
# <p>The version of <code>gawk</code>.
# </p></dd>
# </dl>
# 
# <p>The following additional elements in the array
# are available to provide information about the MPFR and GMP libraries
# if your version of <code>gawk</code> supports arbitrary-precision arithmetic
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Arbitrary-Precision-Arithmetic.html">Arithmetic and Arbitrary-Precision Arithmetic with <code>gawk</code></a>):
# </p>
# <dl compact="compact">
# <dt><code>PROCINFO[&quot;gmp_version&quot;]</code></dt>
# <dd><p>The version of the GNU MP library.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;mpfr_version&quot;]</code></dt>
# <dd><p>The version of the GNU MPFR library.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;prec_max&quot;]</code></dt>
# <dd><p>The maximum precision supported by MPFR.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;prec_min&quot;]</code></dt>
# <dd><p>The minimum precision required by MPFR.
# </p></dd>
# </dl>
# 
# <p>The following additional elements in the array are available to provide
# information about the version of the extension API, if your version
# of <code>gawk</code> supports dynamic loading of extension functions
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Dynamic-Extensions.html">Writing Extensions for <code>gawk</code></a>):
# </p>
# <dl compact="compact">
# <dt><code>PROCINFO[&quot;api_major&quot;]</code></dt>
# <dd>
# <p>The major version of the extension API.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;api_minor&quot;]</code></dt>
# <dd><p>The minor version of the extension API.
# </p></dd>
# </dl>
# 
# <p>On some systems, there may be elements in the array, <code>&quot;group1&quot;</code>
# through <code>&quot;group<var>N</var>&quot;</code> for some <var>N</var>. <var>N</var> is the number of
# supplementary groups that the process has.  Use the <code>in</code> operator
# to test for these elements
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Reference-to-Elements.html">Referring to an Array Element</a>).
# </p>
# <p>The following elements allow you to change <code>gawk</code>&rsquo;s behavior:
# </p>
# <dl compact="compact">
# <dt><code>PROCINFO[&quot;NONFATAL&quot;]</code></dt>
# <dd><p>If this element exists, then I/O errors for all redirections become nonfatal.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Nonfatal.html">Enabling Nonfatal Output</a>.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;<var>name</var>&quot;, &quot;NONFATAL&quot;]</code></dt>
# <dd><p>Make I/O errors for <var>name</var> be nonfatal.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Nonfatal.html">Enabling Nonfatal Output</a>.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;<var>command</var>&quot;, &quot;pty&quot;]</code></dt>
# <dd><p>For two-way communication to <var>command</var>, use a pseudo-tty instead
# of setting up a two-way pipe.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Two_002dway-I_002fO.html">Two-Way Communications with Another Process</a> for more information.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;<var>input_name</var>&quot;, &quot;READ_TIMEOUT&quot;]</code></dt>
# <dd><p>Set a timeout for reading from input redirection <var>input_name</var>.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Read-Timeout.html">Reading Input with a Timeout</a> for more information.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;<var>input_name</var>&quot;, &quot;RETRY&quot;]</code></dt>
# <dd><p>If an I/O error that may be retried occurs when reading data from
# <var>input_name</var>, and this array entry exists, then <code>getline</code> returns
# -2 instead of following the default behavior of returning -1
# and configuring <var>input_name</var> to return no further data.  An I/O error
# that may be retried is one where <code>errno</code> has the value <code>EAGAIN</code>,
# <code>EWOULDBLOCK</code>, <code>EINTR</code>, or <code>ETIMEDOUT</code>.  This may be useful
# in conjunction with <code>PROCINFO[&quot;<var>input_name</var>&quot;, &quot;READ_TIMEOUT&quot;]</code>
# or situations where a file descriptor has been configured to behave in
# a non-blocking fashion.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Retrying-Input.html">Retrying Reads After Certain Input Errors</a> for more information.
# </p>
# </dd>
# <dt><code>PROCINFO[&quot;sorted_in&quot;]</code></dt>
# <dd><p>If this element exists in <code>PROCINFO</code>, its value controls the
# order in which array indices will be processed by
# &lsquo;<samp>for (<var>indx</var> in <var>array</var>)</samp>&rsquo; loops.
# This is an advanced feature, so we defer the
# full description until later; see
# <a href="https://www.gnu.org/software/gawk/manual/html_node/Controlling-Scanning.html">Using Predefined Array Scanning Orders with <code>gawk</code></a>.
# </p></dd>
# </dl>
# 
# </dd>
gawk::PROCINFO = ""

# <dt><code>RLENGTH</code></dt>
# <dd><p>The length of the substring matched by the
# <code>match()</code> function
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html">String-Manipulation Functions</a>).
# <code>RLENGTH</code> is set by invoking the <code>match()</code> function.  Its value
# is the length of the matched string, or -1 if no match is found.
# </p>
# </dd>
awk::RLENGTH = ""

# <dt><code>RSTART</code></dt>
# <dd><p>The start index in characters of the substring that is matched by the
# <code>match()</code> function
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html">String-Manipulation Functions</a>).
# <code>RSTART</code> is set by invoking the <code>match()</code> function.  Its value
# is the position of the string where the matched substring starts, or zero
# if no match was found.
# </p>
# </dd>
awk::RSTART = ""

# <dt><code>RT</code></dt>
# <dd><p>The input text that matched the text denoted by <code>RS</code>,
# the record separator.  It is set every time a record is read.
# </p>
# </dd>
gawk::RT = ""

# <dt><code>SYMTAB</code></dt>
# <dd><p>An array whose indices are the names of all defined global variables and
# arrays in the program.  <code>SYMTAB</code> makes <code>gawk</code>&rsquo;s symbol table
# visible to the <code>awk</code> programmer.  It is built as <code>gawk</code>
# parses the program and is complete before the program starts to run.
# </p>
# <p>The array may be used for indirect access to read or write the value of
# a variable:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">foo = 5
# SYMTAB[&quot;foo&quot;] = 4
# print foo    # prints 4
# </pre></div>
# 
# <p>The <code>isarray()</code> function (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Type-Functions.html">Getting Type Information</a>) may be used to test
# if an element in <code>SYMTAB</code> is an array.
# Also, you may not use the <code>delete</code> statement with the
# <code>SYMTAB</code> array.
# </p>
# <p>Prior to version 5.0 of <code>gawk</code>, you could
# use an index for <code>SYMTAB</code> that was not a predefined identifier:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">SYMTAB[&quot;xxx&quot;] = 5
# print SYMTAB[&quot;xxx&quot;]
# </pre></div>
# 
# <p>This no longer works, instead producing a fatal error, as it led
# to rampant confusion.
# </p>
# <p>The <code>SYMTAB</code> array is more interesting than it looks. Andrew Schorr
# points out that it effectively gives <code>awk</code> data pointers. Consider his
# example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example"># Indirect multiply of any variable by amount, return result
# 
# function multiply(variable, amount)
# {
# &nbsp;&nbsp;&nbsp;&nbsp;return SYMTAB[variable] *= amount
# }
# </pre></div>
# 
# <p>You would use it like this:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">BEGIN {
# &nbsp;&nbsp;&nbsp;&nbsp;answer = 10.5
# &nbsp;&nbsp;&nbsp;&nbsp;multiply(&quot;answer&quot;, 4)
# &nbsp;&nbsp;&nbsp;&nbsp;print &quot;The answer is&quot;, answer
# }
# </pre></div>
# 
# <p>When run, this produces:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>gawk -f answer.awk</kbd>
# -| The answer is 42
# </pre></div>
# 
# <blockquote>
# <p><b>NOTE:</b> In order to avoid severe time-travel paradoxes, neither <code>FUNCTAB</code> nor <code>SYMTAB</code>
# is available as an element within the <code>SYMTAB</code> array.
# </p></blockquote>
# </dd>
gawk::SYMTAB = ""
}

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
# otherwise, return NaN (&ldquo;not a number&rdquo;) on IEEE 754 systems.
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
# <dd><p>Set the starting point, or seed,
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a>).  If the
# <var>source</var> array contains subarrays as values (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Arrays-of-Arrays.html">Arrays of Arrays</a>), they will come last, after all scalar values.
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Array-Sorting-Functions.html">Sorting Array Values and Indices with <code>gawk</code></a>).  If the
# <var>source</var> array contains subarrays as values (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Arrays-of-Arrays.html">Arrays of Arrays</a>), they will come last, after all scalar values.
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
# <dd><p>Search <var>target</var> for
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>),
# <code>gawk</code> warns that passing an array argument is not portable.
# If <samp>--posix</samp> is supplied, using an array argument is a fatal error
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Arrays.html">Arrays in <code>awk</code></a>).
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
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Computed-Regexps.html">Using Dynamic Regexps</a> for a
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Reference-to-Elements.html">Referring to an Array Element</a>).
# </p>
# <p>The <var>array</var> argument to <code>match()</code> is a
# <code>gawk</code> extension.  In compatibility mode
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>),
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Splitting-By-Content.html">Defining Fields by Content</a>).
# </p>
# <p>Before splitting the string, <code>patsplit()</code> deletes any previously existing
# elements in the arrays <var>array</var> and <var>seps</var>.
# </p>
# </dd>
function gawk::patsplit() {}

# <dt><code>split(<var>string</var>, <var>array</var></code> [<code>, <var>fieldsep</var></code> [<code>, <var>seps</var></code> ] ]<code>)</code></dt>
# <dd><p>Divide <var>string</var> into pieces separated by <var>fieldsep</var>
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
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Computed-Regexps.html">Using Dynamic Regexps</a> for a
# discussion of the difference between using a string constant or a regexp constant,
# and the implications for writing your program correctly.
# </p>
# <p>Before splitting the string, <code>split()</code> deletes any previously existing
# elements in the arrays <var>array</var> and <var>seps</var>.
# </p>
# <p>If <var>string</var> is null, the array has no elements. (So this is a portable
# way to delete an entire array with one statement.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Delete.html">The <code>delete</code> Statement</a>.)
# </p>
# <p>If <var>string</var> does not match <var>fieldsep</var> at all (but is not null),
# <var>array</var> has one element only. The value of that element is the original
# <var>string</var>.
# </p>
# <p>In POSIX mode (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>), the fourth argument is not allowed.
# </p>
# </dd>
function awk::split() {}

# <dt><code>sprintf(<var>format</var>, <var>expression1</var>, &hellip;)</code></dt>
# <dd>
# <p>Return (without printing) the string that <code>printf</code> would
# have printed out with the same arguments
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Printf.html">Using <code>printf</code> Statements for Fancier Printing</a>).
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">pival = sprintf(&quot;pi = %.2f (approx.)&quot;, 22/7)
# </pre></div>
# 
# <p>assigns the string &lsquo;<samp>pi&nbsp;=&nbsp;3.14&nbsp;(approx.)</samp>&rsquo;<!-- /@w --> to the variable <code>pival</code>.
# </p>
# </dd>
# <br>
# <h3 class="subsection">Format-Control Letters</h3>
# 
# <p>A format specifier starts with the character &lsquo;<samp>%</samp>&rsquo; and ends with
# a <em>format-control letter</em>&mdash;it tells the <code>printf</code> statement
# how to output one item.  The format-control letter specifies what <em>kind</em>
# of value to print.  The rest of the format specifier is made up of
# optional <em>modifiers</em> that control <em>how</em> to print the value, such as
# the field width.  Here is a list of the format-control letters:
# </p>
# <dl compact="compact">
# <dt><code>%a</code>, <code>%A</code></dt>
# <dd><p>A floating point number of the form
# [<code>-</code>]<code>0x<var>h</var>.<var>hhhh</var>p+-<var>dd</var></code>
# (C99 hexadecimal floating point format).
# For <code>%A</code>,
# uppercase letters are used instead of lowercase ones.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The current POSIX standard requires support for <code>%a</code> and <code>%A</code> in
# <code>awk</code>. As far as we know, besides <code>gawk</code>, the only other
# version of <code>awk</code> that actually implements it is BWK <code>awk</code>.
# It&rsquo;s use is thus highly nonportable!
# </p>
# <p>Furthermore, these formats are not available on any system where the
# underlying C library <code>printf()</code> function does not support them. As
# of this writing, among current systems, only OpenVMS is known to not
# support them.
# </p></blockquote>
# 
# </dd>
# <dt><code>%c</code></dt>
# <dd><p>Print a number as a character; thus, &lsquo;<samp>printf &quot;%c&quot;,
# 65</samp>&rsquo; outputs the letter &lsquo;<samp>A</samp>&rsquo;. The output for a string value is
# the first character of the string.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The POSIX standard says the first character of a string is printed.
# In locales with multibyte characters, <code>gawk</code> attempts to
# convert the leading bytes of the string into a valid wide character
# and then to print the multibyte encoding of that character.
# Similarly, when printing a numeric value, <code>gawk</code> allows the
# value to be within the numeric range of values that can be held
# in a wide character.
# If the conversion to multibyte encoding fails, <code>gawk</code>
# uses the low eight bits of the value as the character to print.
# </p>
# <p>Other <code>awk</code> versions generally restrict themselves to printing
# the first byte of a string or to numeric values within the range of
# a single byte (0&ndash;255).
# (d.c.)
# </p></blockquote>
# 
# 
# </dd>
# <dt><code>%d</code>, <code>%i</code></dt>
# <dd><p>Print a decimal integer.
# The two control letters are equivalent.
# (The &lsquo;<samp>%i</samp>&rsquo; specification is for compatibility with ISO C.)
# </p>
# </dd>
# <dt><code>%e</code>, <code>%E</code></dt>
# <dd><p>Print a number in scientific (exponential) notation.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4.3e\n&quot;, 1950
# </pre></div>
# 
# <p>prints &lsquo;<samp>1.950e+03</samp>&rsquo;, with a total of four significant figures, three of
# which follow the decimal point.
# (The &lsquo;<samp>4.3</samp>&rsquo; represents two modifiers,
# discussed in the next subsection.)
# &lsquo;<samp>%E</samp>&rsquo; uses &lsquo;<samp>E</samp>&rsquo; instead of &lsquo;<samp>e</samp>&rsquo; in the output.
# </p>
# </dd>
# <dt><code>%f</code></dt>
# <dd><p>Print a number in floating-point notation.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4.3f&quot;, 1950
# </pre></div>
# 
# <p>prints &lsquo;<samp>1950.000</samp>&rsquo;, with a minimum of four significant figures, three of
# which follow the decimal point.
# (The &lsquo;<samp>4.3</samp>&rsquo; represents two modifiers,
# discussed in the next subsection.)
# </p>
# <p>On systems supporting IEEE 754 floating-point format, values
# representing negative
# infinity are formatted as
# &lsquo;<samp>-inf</samp>&rsquo; or &lsquo;<samp>-infinity</samp>&rsquo;,
# and positive infinity as
# &lsquo;<samp>inf</samp>&rsquo; or &lsquo;<samp>infinity</samp>&rsquo;.
# The special &ldquo;not a number&rdquo; value formats as &lsquo;<samp>-nan</samp>&rsquo; or &lsquo;<samp>nan</samp>&rsquo;
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Strange-values.html">Floating Point Values They Didn&rsquo;t Talk About In School</a>).
# </p>
# </dd>
# <dt><code>%F</code></dt>
# <dd><p>Like &lsquo;<samp>%f</samp>&rsquo;, but the infinity and &ldquo;not a number&rdquo; values are spelled
# using uppercase letters.
# </p>
# <p>The &lsquo;<samp>%F</samp>&rsquo; format is a POSIX extension to ISO C; not all systems
# support it.  On those that don&rsquo;t, <code>gawk</code> uses &lsquo;<samp>%f</samp>&rsquo; instead.
# </p>
# </dd>
# <dt><code>%g</code>, <code>%G</code></dt>
# <dd><p>Print a number in either scientific notation or in floating-point
# notation, whichever uses fewer characters; if the result is printed in
# scientific notation, &lsquo;<samp>%G</samp>&rsquo; uses &lsquo;<samp>E</samp>&rsquo; instead of &lsquo;<samp>e</samp>&rsquo;.
# </p>
# </dd>
# <dt><code>%o</code></dt>
# <dd><p>Print an unsigned octal integer
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Nondecimal_002dnumbers.html">Octal and Hexadecimal Numbers</a>).
# </p>
# </dd>
# <dt><code>%s</code></dt>
# <dd><p>Print a string.
# </p>
# </dd>
# <dt><code>%u</code></dt>
# <dd><p>Print an unsigned decimal integer.
# (This format is of marginal use, because all numbers in <code>awk</code>
# are floating point; it is provided primarily for compatibility with C.)
# </p>
# </dd>
# <dt><code>%x</code>, <code>%X</code></dt>
# <dd><p>Print an unsigned hexadecimal integer;
# &lsquo;<samp>%X</samp>&rsquo; uses the letters &lsquo;<samp>A</samp>&rsquo; through &lsquo;<samp>F</samp>&rsquo;
# instead of &lsquo;<samp>a</samp>&rsquo; through &lsquo;<samp>f</samp>&rsquo;
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Nondecimal_002dnumbers.html">Octal and Hexadecimal Numbers</a>).
# </p>
# </dd>
# <dt><code>%%</code></dt>
# <dd><p>Print a single &lsquo;<samp>%</samp>&rsquo;.
# This does not consume an
# argument and it ignores any modifiers.
# </p></dd>
# </dl>
# 
# <blockquote>
# <p><b>NOTE:</b> When using the integer format-control letters for values that are
# outside the range of the widest C integer type, <code>gawk</code> switches to
# the &lsquo;<samp>%g</samp>&rsquo; format specifier. If <samp>--lint</samp> is provided on the
# command line (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>), <code>gawk</code>
# warns about this.  Other versions of <code>awk</code> may print invalid
# values or do something else entirely.
# (d.c.)
# </p></blockquote>
# 
# <blockquote>
# <p><b>NOTE:</b> The IEEE 754 standard for floating-point arithmetic allows for special
# values that represent &ldquo;infinity&rdquo; (positive and negative) and values
# that are &ldquo;not a number&rdquo; (NaN).
# </p>
# <p>Input and output of these values occurs as text strings. This is
# somewhat problematic for the <code>awk</code> language, which predates
# the IEEE standard.  Further details are provided in
# <a href="https://www.gnu.org/software/gawk/manual/html_node/POSIX-Floating-Point-Problems.html">Standards Versus Existing Practice</a>; please see there.
# </p></blockquote>
# 
# 
# <br>
# <h3 class="subsection">Modifiers for <code>printf</code> Formats</h3>
# 
# <p>A format specification can also include <em>modifiers</em> that can control
# how much of the item&rsquo;s value is printed, as well as how much space it gets.
# The modifiers come between the &lsquo;<samp>%</samp>&rsquo; and the format-control letter.
# We use the bullet symbol &ldquo;&bull;&rdquo; in the following examples to
# represent
# spaces in the output. Here are the possible modifiers, in the order in
# which they may appear:
# </p>
# <dl compact="compact">
# <dd>
# </dd>
# <dt><code><var>N</var>$</code></dt>
# <dd><p>An integer constant followed by a &lsquo;<samp>$</samp>&rsquo; is a <em>positional specifier</em>.
# Normally, format specifications are applied to arguments in the order
# given in the format string.  With a positional specifier, the format
# specification is applied to a specific argument, instead of what
# would be the next argument in the list.  Positional specifiers begin
# counting with one. Thus:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%s %s\n&quot;, &quot;don't&quot;, &quot;panic&quot;
# printf &quot;%2$s %1$s\n&quot;, &quot;panic&quot;, &quot;don't&quot;
# </pre></div>
# 
# <p>prints the famous friendly message twice.
# </p>
# <p>At first glance, this feature doesn&rsquo;t seem to be of much use.
# It is in fact a <code>gawk</code> extension, intended for use in translating
# messages at runtime.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Printf-Ordering.html">Rearranging <code>printf</code> Arguments</a>,
# which describes how and why to use positional specifiers.
# For now, we ignore them.
# </p>
# </dd>
# <dt><code>-</code> (Minus)</span></dt>
# <dd><p>The minus sign, used before the width modifier (see later on in
# this list),
# says to left-justify
# the argument within its specified width.  Normally, the argument
# is printed right-justified in the specified width.  Thus:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%-4s&quot;, &quot;foo&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>foo&bull;</samp>&rsquo;.
# </p>
# </dd>
# <dt><span><var>space</var></span></dt>
# <dd><p>For numeric conversions, prefix positive values with a space and
# negative values with a minus sign.
# </p>
# </dd>
# <dt><code>+</code></dt>
# <dd><p>The plus sign, used before the width modifier (see later on in
# this list),
# says to always supply a sign for numeric conversions, even if the data
# to format is positive. The &lsquo;<samp>+</samp>&rsquo; overrides the space modifier.
# </p>
# </dd>
# <dt><code>#</code></dt>
# <dd><p>Use an &ldquo;alternative form&rdquo; for certain control letters.
# For &lsquo;<samp>%o</samp>&rsquo;, supply a leading zero.
# For &lsquo;<samp>%x</samp>&rsquo; and &lsquo;<samp>%X</samp>&rsquo;, supply a leading &lsquo;<samp>0x</samp>&rsquo; or &lsquo;<samp>0X</samp>&rsquo; for
# a nonzero result.
# For &lsquo;<samp>%e</samp>&rsquo;, &lsquo;<samp>%E</samp>&rsquo;, &lsquo;<samp>%f</samp>&rsquo;, and &lsquo;<samp>%F</samp>&rsquo;, the result always
# contains a decimal point.
# For &lsquo;<samp>%g</samp>&rsquo; and &lsquo;<samp>%G</samp>&rsquo;, trailing zeros are not removed from the result.
# </p>
# </dd>
# <dt><code>0</code></dt>
# <dd><p>A leading &lsquo;<samp>0</samp>&rsquo; (zero) acts as a flag indicating that output should be
# padded with zeros instead of spaces.
# This applies only to the numeric output formats.
# This flag only has an effect when the field width is wider than the
# value to print.
# </p>
# </dd>
# <dt><code>'</code></dt>
# <dd><p>A single quote or apostrophe character is a POSIX extension to ISO C.
# It indicates that the integer part of a floating-point value, or the
# entire part of an integer decimal value, should have a thousands-separator
# character in it.  This only works in locales that support such characters.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>cat thousands.awk</kbd>          <i>Show source program</i>
# -| BEGIN { printf &quot;%'d\n&quot;, 1234567 }
# $ <kbd>LC_ALL=C gawk -f thousands.awk</kbd>
# -| 1234567                   <i>Results in</i> &quot;C&quot; <i>locale</i>
# $ <kbd>LC_ALL=en_US.UTF-8 gawk -f thousands.awk</kbd>
# -| 1,234,567                 <i>Results in US English UTF locale</i>
# </pre></div>
# 
# <p>For more information about locales and internationalization issues,
# see <a href="https://www.gnu.org/software/gawk/manual/html_node/Locales.html">Where You Are Makes a Difference</a>.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The &lsquo;<samp>'</samp>&rsquo; flag is a nice feature, but its use complicates things: it
# becomes difficult to use it in command-line programs.  For information
# on appropriate quoting tricks, see <a href="https://www.gnu.org/software/gawk/manual/html_node/Quoting.html">Shell Quoting Issues</a>.
# </p></blockquote>
# 
# </dd>
# <dt><span><var>width</var></span></dt>
# <dd><p>This is a number specifying the desired minimum width of a field.  Inserting any
# number between the &lsquo;<samp>%</samp>&rsquo; sign and the format-control character forces the
# field to expand to this width.  The default way to do this is to
# pad with spaces on the left.  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4s&quot;, &quot;foo&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>&bull;foo</samp>&rsquo;.
# </p>
# <p>The value of <var>width</var> is a minimum width, not a maximum.  If the item
# value requires more than <var>width</var> characters, it can be as wide as
# necessary.  Thus, the following:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4s&quot;, &quot;foobar&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>foobar</samp>&rsquo;.
# </p>
# <p>Preceding the <var>width</var> with a minus sign causes the output to be
# padded with spaces on the right, instead of on the left.
# </p>
# </dd>
# <dt><code>.<var>prec</var></code></dt>
# <dd><p>A period followed by an integer constant
# specifies the precision to use when printing.
# The meaning of the precision varies by control letter:
# </p>
# <dl compact="compact">
# <dt><code>%d</code>, <code>%i</code>, <code>%o</code>, <code>%u</code>, <code>%x</code>, <code>%X</code></dt>
# <dd><p>Minimum number of digits to print.
# </p>
# </dd>
# <dt><code>%e</code>, <code>%E</code>, <code>%f</code>, <code>%F</code></dt>
# <dd><p>Number of digits to the right of the decimal point.
# </p>
# </dd>
# <dt><code>%g</code>, <code>%G</code></dt>
# <dd><p>Maximum number of significant digits.
# </p>
# </dd>
# <dt><code>%s</code></dt>
# <dd><p>Maximum number of characters from the string that should print.
# </p></dd>
# </dl>
# 
# <p>Thus, the following:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%.4s&quot;, &quot;foobar&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>foob</samp>&rsquo;.
# </p></dd>
# </dl>
# 
# <p>The C library <code>printf</code>&rsquo;s dynamic <var>width</var> and <var>prec</var>
# capability (e.g., <code>&quot;%*.*s&quot;</code>) is supported.  Instead of
# supplying explicit <var>width</var> and/or <var>prec</var> values in the format
# string, they are passed in the argument list.  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">w = 5
# p = 3
# s = &quot;abcdefg&quot;
# printf &quot;%*.*s\n&quot;, w, p, s
# </pre></div>
# 
# <p>is exactly equivalent to:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">s = &quot;abcdefg&quot;
# printf &quot;%5.3s\n&quot;, s
# </pre></div>
# 
# <p>Both programs output &lsquo;<samp>&bull;&bull;abc<!-- /@w --></samp>&rsquo;.
# Earlier versions of <code>awk</code> did not support this capability.
# If you must use such a version, you may simulate this feature by using
# concatenation to build up the format string, like so:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">w = 5
# p = 3
# s = &quot;abcdefg&quot;
# printf &quot;%&quot; w &quot;.&quot; p &quot;s\n&quot;, s
# </pre></div>
# 
# <p>This is not particularly easy to read, but it does work.
# </p>
# <p>C programmers may be used to supplying additional modifiers (&lsquo;<samp>h</samp>&rsquo;,
# &lsquo;<samp>j</samp>&rsquo;, &lsquo;<samp>l</samp>&rsquo;, &lsquo;<samp>L</samp>&rsquo;, &lsquo;<samp>t</samp>&rsquo;, and &lsquo;<samp>z</samp>&rsquo;) in <code>printf</code>
# format strings. These are not valid in <code>awk</code>.  Most <code>awk</code>
# implementations silently ignore them.  If <samp>--lint</samp> is provided
# on the command line (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>), <code>gawk</code> warns about their
# use. If <samp>--posix</samp> is supplied, their use is a fatal error.
# </p>
# 
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
# for recognizing numbers (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Locales.html">Where You Are Makes a Difference</a>).
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
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Computed-Regexps.html">Using Dynamic Regexps</a> for a
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Leftmost-Longest.html">How Much Text Matches?</a>).
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
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Close-Files-And-Pipes.html">Closing Input and Output Redirections</a>
# for more information.
# </p>
# <p>When closing a coprocess, it is occasionally useful to first close
# one end of the two-way pipe and then to close the other.  This is done
# by providing a second argument to <code>close()</code>.  This second argument
# (<var>how</var>)
# should be one of the two string values <code>&quot;to&quot;</code> or <code>&quot;from&quot;</code>,
# indicating which end of the pipe to close.  Case in the string does
# not matter.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Two_002dway-I_002fO.html">Two-Way Communications with Another Process</a>,
# which discusses this feature in more detail and gives an example.
# </p>
# <p>Note that the second argument to <code>close()</code> is a <code>gawk</code>
# extension; it is not available in compatibility mode (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>).
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>).
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
# The return values are summarized in table below.
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
# <div class="float-caption"><p><strong>Table: </strong>Return values from <code>system()</code></p></div></div></dd>
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
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Built_002din-Variables.html">Predefined Variables</a>).
# The default string value is
# <code>&quot;%a&nbsp;%b&nbsp;%e&nbsp;%H:%M:%S&nbsp;%Z&nbsp;%Y&quot;<!-- /@w --></code>.  This format string produces
# output that is equivalent to that of the <code>date</code> utility.
# You can assign a new value to <code>PROCINFO[&quot;strftime&quot;]</code> to
# change the default format; see the following list for the various format directives.
# </p>
# </dd>
# <br>
# <h3>Format-Control Letters</h3>
# <p>The <code>strftime()</code> function allows you to easily turn a timestamp
# into human-readable information.  It is similar in nature to the <code>sprintf()</code>
# function
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html">String-Manipulation Functions</a>),
# in that it copies nonformat specification characters verbatim to the
# returned string, while substituting date and time values for format
# specifications in the <var>format</var> string.
# </p>
# <p><code>strftime()</code> is guaranteed by the 1999 ISO C
# standard
# to support the following date format specifications:
# </p>
# <dl compact="compact">
# <dt><code>%a</code></dt>
# <dd><p>The locale&rsquo;s abbreviated weekday name.
# </p>
# </dd>
# <dt><code>%A</code></dt>
# <dd><p>The locale&rsquo;s full weekday name.
# </p>
# </dd>
# <dt><code>%b</code></dt>
# <dd><p>The locale&rsquo;s abbreviated month name.
# </p>
# </dd>
# <dt><code>%B</code></dt>
# <dd><p>The locale&rsquo;s full month name.
# </p>
# </dd>
# <dt><code>%c</code></dt>
# <dd><p>The locale&rsquo;s &ldquo;appropriate&rdquo; date and time representation.
# (This is &lsquo;<samp>%A %B %d %T %Y</samp>&rsquo; in the <code>&quot;C&quot;</code> locale.)
# </p>
# </dd>
# <dt><code>%C</code></dt>
# <dd><p>The century part of the current year.
# This is the year divided by 100 and truncated to the next
# lower integer.
# </p>
# </dd>
# <dt><code>%d</code></dt>
# <dd><p>The day of the month as a decimal number (01&ndash;31).
# </p>
# </dd>
# <dt><code>%D</code></dt>
# <dd><p>Equivalent to specifying &lsquo;<samp>%m/%d/%y</samp>&rsquo;.
# </p>
# </dd>
# <dt><code>%e</code></dt>
# <dd><p>The day of the month, padded with a space if it is only one digit.
# </p>
# </dd>
# <dt><code>%F</code></dt>
# <dd><p>Equivalent to specifying &lsquo;<samp>%Y-%m-%d</samp>&rsquo;.
# This is the ISO 8601 date format.
# </p>
# </dd>
# <dt><code>%g</code></dt>
# <dd><p>The year modulo 100 of the ISO 8601 week number, as a decimal number (00&ndash;99).
# For example, January 1, 2012, is in week 53 of 2011. Thus, the year
# of its ISO 8601 week number is 2011, even though its year is 2012.
# Similarly, December 31, 2012, is in week 1 of 2013. Thus, the year
# of its ISO week number is 2013, even though its year is 2012.
# </p>
# </dd>
# <dt><code>%G</code></dt>
# <dd><p>The full year of the ISO week number, as a decimal number.
# </p>
# </dd>
# <dt><code>%h</code></dt>
# <dd><p>Equivalent to &lsquo;<samp>%b</samp>&rsquo;.
# </p>
# </dd>
# <dt><code>%H</code></dt>
# <dd><p>The hour (24-hour clock) as a decimal number (00&ndash;23).
# </p>
# </dd>
# <dt><code>%I</code></dt>
# <dd><p>The hour (12-hour clock) as a decimal number (01&ndash;12).
# </p>
# </dd>
# <dt><code>%j</code></dt>
# <dd><p>The day of the year as a decimal number (001&ndash;366).
# </p>
# </dd>
# <dt><code>%m</code></dt>
# <dd><p>The month as a decimal number (01&ndash;12).
# </p>
# </dd>
# <dt><code>%M</code></dt>
# <dd><p>The minute as a decimal number (00&ndash;59).
# </p>
# </dd>
# <dt><code>%n</code></dt>
# <dd><p>A newline character (ASCII LF).
# </p>
# </dd>
# <dt><code>%p</code></dt>
# <dd><p>The locale&rsquo;s equivalent of the AM/PM designations associated
# with a 12-hour clock.
# </p>
# </dd>
# <dt><code>%r</code></dt>
# <dd><p>The locale&rsquo;s 12-hour clock time.
# (This is &lsquo;<samp>%I:%M:%S %p</samp>&rsquo; in the <code>&quot;C&quot;</code> locale.)
# </p>
# </dd>
# <dt><code>%R</code></dt>
# <dd><p>Equivalent to specifying &lsquo;<samp>%H:%M</samp>&rsquo;.
# </p>
# </dd>
# <dt><code>%S</code></dt>
# <dd><p>The second as a decimal number (00&ndash;60).
# </p>
# </dd>
# <dt><code>%t</code></dt>
# <dd><p>A TAB character.
# </p>
# </dd>
# <dt><code>%T</code></dt>
# <dd><p>Equivalent to specifying &lsquo;<samp>%H:%M:%S</samp>&rsquo;.
# </p>
# </dd>
# <dt><code>%u</code></dt>
# <dd><p>The weekday as a decimal number (1&ndash;7).  Monday is day one.
# </p>
# </dd>
# <dt><code>%U</code></dt>
# <dd><p>The week number of the year (with the first Sunday as the first day of week one)
# as a decimal number (00&ndash;53).
# </p>
# </dd>
# <dt><code>%V</code></dt>
# <dd><p>The week number of the year (with the first Monday as the first
# day of week one) as a decimal number (01&ndash;53).
# The method for determining the week number is as specified by ISO 8601.
# (To wit: if the week containing January 1 has four or more days in the
# new year, then it is week one; otherwise it is the last week
# [52 or 53] of the previous year and the next week is week one.)
# </p>
# </dd>
# <dt><code>%w</code></dt>
# <dd><p>The weekday as a decimal number (0&ndash;6).  Sunday is day zero.
# </p>
# </dd>
# <dt><code>%W</code></dt>
# <dd><p>The week number of the year (with the first Monday as the first day of week one)
# as a decimal number (00&ndash;53).
# </p>
# </dd>
# <dt><code>%x</code></dt>
# <dd><p>The locale&rsquo;s &ldquo;appropriate&rdquo; date representation.
# (This is &lsquo;<samp>%A %B %d %Y</samp>&rsquo; in the <code>&quot;C&quot;</code> locale.)
# </p>
# </dd>
# <dt><code>%X</code></dt>
# <dd><p>The locale&rsquo;s &ldquo;appropriate&rdquo; time representation.
# (This is &lsquo;<samp>%T</samp>&rsquo; in the <code>&quot;C&quot;</code> locale.)
# </p>
# </dd>
# <dt><code>%y</code></dt>
# <dd><p>The year modulo 100 as a decimal number (00&ndash;99).
# </p>
# </dd>
# <dt><code>%Y</code></dt>
# <dd><p>The full year as a decimal number (e.g., 2015).
# </p>
# </dd>
# <dt><code>%z</code></dt>
# <dd><p>The time zone offset in a &lsquo;<samp>+<var>HHMM</var></samp>&rsquo; format (e.g., the format
# necessary to produce RFC 822/RFC 1036 date headers).
# </p>
# </dd>
# <dt><code>%Z</code></dt>
# <dd><p>The time zone name or abbreviation; no characters if
# no time zone is determinable.
# </p>
# </dd>
# <dt><code>%Ec %EC %Ex %EX %Ey %EY %Od %Oe %OH</code></dt>
# <dt><code>%OI %Om %OM %OS %Ou %OU %OV %Ow %OW %Oy</code></dt>
# <dd><p>&ldquo;Alternative representations&rdquo; for the specifications
# that use only the second letter (&lsquo;<samp>%c</samp>&rsquo;, &lsquo;<samp>%C</samp>&rsquo;,
# and so on).
# (These facilitate compliance with the POSIX <code>date</code> utility.)
# </p>
# </dd>
# <dt><code>%%</code></dt>
# <dd><p>A literal &lsquo;<samp>%</samp>&rsquo;.
# </p></dd>
# </dl>
# 
# <p>If a conversion specifier is not one of those just listed, the behavior is
# undefined.
# </p>
# <p>For systems that are not yet fully standards-compliant,
# <code>gawk</code> supplies a copy of
# <code>strftime()</code> from the GNU C Library.
# It supports all of the just-listed format specifications.
# If that version is
# used to compile <code>gawk</code> (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Installation.html">Installing <code>gawk</code></a>),
# then the following additional format specifications are available:
# </p>
# <dl compact="compact">
# <dt><code>%k</code></dt>
# <dd><p>The hour (24-hour clock) as a decimal number (0&ndash;23).
# Single-digit numbers are padded with a space.
# </p>
# </dd>
# <dt><code>%l</code></dt>
# <dd><p>The hour (12-hour clock) as a decimal number (1&ndash;12).
# Single-digit numbers are padded with a space.
# </p>
# 
# </dd>
# <dt><code>%s</code></dt>
# <dd><p>The time as a decimal timestamp in seconds since the epoch.
# </p>
# </dd>
# </dl>
# 
function gawk::strftime() {}

# <dt><code>systime()</code></dt>
# <dd>
# <p>Return the current time as the number of seconds since
# the system epoch.  On POSIX systems, this is the number of seconds
# since 1970-01-01 00:00:00 UTC, not counting leap seconds.
# It may be a different number on other systems.
# </p></dd>
function gawk::systime() {}

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
# <dd><p><var>x</var> is a strongly typed regexp (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Strong-Regexp-Constants.html">Strongly Typed Regexp Constants</a>).
# </p>
# </dd>
# <dt><code>&quot;number&quot;</code></dt>
# <dd><p><var>x</var> is a number.
# </p>
# </dd>
# <dt><code>&quot;number|bool&quot;</code></dt>
# <dd><p><var>x</var> is a Boolean typed value (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Boolean-Typed-Values.html">Boolean Typed Values</a>).
# </p>
# </dd>
# <dt><code>&quot;string&quot;</code></dt>
# <dd><p><var>x</var> is a string.
# </p>
# </dd>
# <dt><code>&quot;strnum&quot;</code></dt>
# <dd><p><var>x</var> is a number that started life as user input, such as a field or
# the result of calling <code>split()</code>. (I.e., <var>x</var> has the strnum
# attribute; see <a href="https://www.gnu.org/software/gawk/manual/html_node/Variable-Typing.html">String Type versus Numeric Type</a>.)
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
# </dl>
# 
function gawk::typeof() {}

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

# 
# <p>The <code>exit</code> statement causes <code>awk</code> to immediately stop
# executing the current rule and to stop processing input; any remaining input
# is ignored.  The <code>exit</code> statement is written as follows:
# </p>
# <div class="display">
# <pre class="display"><code>exit</code> [<var>return code</var>]
# </pre></div>
# 
# <p>When an <code>exit</code> statement is executed from a <code>BEGIN</code> rule, the
# program stops processing everything immediately.  No input records are
# read.  However, if an <code>END</code> rule is present,
# as part of executing the <code>exit</code> statement,
# the <code>END</code> rule is executed
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/BEGIN_002fEND.html">The <code>BEGIN</code> and <code>END</code> Special Patterns</a>).
# If <code>exit</code> is used in the body of an <code>END</code> rule, it causes
# the program to stop immediately.
# </p>
# <p>An <code>exit</code> statement that is not part of a <code>BEGIN</code> or <code>END</code>
# rule stops the execution of any further automatic rules for the current
# record, skips reading any remaining input records, and executes the
# <code>END</code> rule if there is one.  <code>gawk</code> also skips
# any <code>ENDFILE</code> rules; they do not execute.
# </p>
# <p>In such a case,
# if you don&rsquo;t want the <code>END</code> rule to do its job, set a variable
# to a nonzero value before the <code>exit</code> statement and check that variable in
# the <code>END</code> rule.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Assert-Function.html">Assertions</a>
# for an example that does this.
# </p>
# <p>If an argument is supplied to <code>exit</code>, its value is used as the exit
# status code for the <code>awk</code> process.  If no argument is supplied,
# <code>exit</code> causes <code>awk</code> to return a &ldquo;success&rdquo; status.
# In the case where an argument
# is supplied to a first <code>exit</code> statement, and then <code>exit</code> is
# called a second time from an <code>END</code> rule with no argument,
# <code>awk</code> uses the previously supplied exit value.  (d.c.)
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Exit-Status.html"><code>gawk</code>&rsquo;s Exit Status</a> for more information.
# </p>
# <p>For example, suppose an error condition occurs that is difficult or
# impossible to handle.  Conventionally, programs report this by
# exiting with a nonzero status.  An <code>awk</code> program can do this
# using an <code>exit</code> statement with a nonzero argument, as shown
# in the following example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">BEGIN {
# &nbsp;&nbsp;&nbsp;&nbsp;if ((&quot;date&quot; | getline date_now) &lt;= 0) {
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print &quot;Can't get system date&quot; &gt; &quot;/dev/stderr&quot;
# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exit 1
# &nbsp;&nbsp;&nbsp;&nbsp;}
# &nbsp;&nbsp;&nbsp;&nbsp;print &quot;current date is&quot;, date_now
# &nbsp;&nbsp;&nbsp;&nbsp;close(&quot;date&quot;)
# }
# </pre></div>
# 
# <blockquote>
# <p><b>NOTE:</b> For full portability, exit values should be between zero and 126, inclusive.
# Negative values, and values of 127 or greater, may not produce consistent
# results across different operating systems.
# </p></blockquote>
# 
# 
# 
function stmt::exit() {}

# <dt><code>printf format, item1, item2, …</code></dt>
# <h3 class="subsection">Format-Control Letters</h3>
# 
# <p>A format specifier starts with the character &lsquo;<samp>%</samp>&rsquo; and ends with
# a <em>format-control letter</em>&mdash;it tells the <code>printf</code> statement
# how to output one item.  The format-control letter specifies what <em>kind</em>
# of value to print.  The rest of the format specifier is made up of
# optional <em>modifiers</em> that control <em>how</em> to print the value, such as
# the field width.  Here is a list of the format-control letters:
# </p>
# <dl compact="compact">
# <dt><code>%a</code>, <code>%A</code></dt>
# <dd><p>A floating point number of the form
# [<code>-</code>]<code>0x<var>h</var>.<var>hhhh</var>p+-<var>dd</var></code>
# (C99 hexadecimal floating point format).
# For <code>%A</code>,
# uppercase letters are used instead of lowercase ones.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The current POSIX standard requires support for <code>%a</code> and <code>%A</code> in
# <code>awk</code>. As far as we know, besides <code>gawk</code>, the only other
# version of <code>awk</code> that actually implements it is BWK <code>awk</code>.
# It&rsquo;s use is thus highly nonportable!
# </p>
# <p>Furthermore, these formats are not available on any system where the
# underlying C library <code>printf()</code> function does not support them. As
# of this writing, among current systems, only OpenVMS is known to not
# support them.
# </p></blockquote>
# 
# </dd>
# <dt><code>%c</code></dt>
# <dd><p>Print a number as a character; thus, &lsquo;<samp>printf &quot;%c&quot;,
# 65</samp>&rsquo; outputs the letter &lsquo;<samp>A</samp>&rsquo;. The output for a string value is
# the first character of the string.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The POSIX standard says the first character of a string is printed.
# In locales with multibyte characters, <code>gawk</code> attempts to
# convert the leading bytes of the string into a valid wide character
# and then to print the multibyte encoding of that character.
# Similarly, when printing a numeric value, <code>gawk</code> allows the
# value to be within the numeric range of values that can be held
# in a wide character.
# If the conversion to multibyte encoding fails, <code>gawk</code>
# uses the low eight bits of the value as the character to print.
# </p>
# <p>Other <code>awk</code> versions generally restrict themselves to printing
# the first byte of a string or to numeric values within the range of
# a single byte (0&ndash;255).
# (d.c.)
# </p></blockquote>
# 
# 
# </dd>
# <dt><code>%d</code>, <code>%i</code></dt>
# <dd><p>Print a decimal integer.
# The two control letters are equivalent.
# (The &lsquo;<samp>%i</samp>&rsquo; specification is for compatibility with ISO C.)
# </p>
# </dd>
# <dt><code>%e</code>, <code>%E</code></dt>
# <dd><p>Print a number in scientific (exponential) notation.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4.3e\n&quot;, 1950
# </pre></div>
# 
# <p>prints &lsquo;<samp>1.950e+03</samp>&rsquo;, with a total of four significant figures, three of
# which follow the decimal point.
# (The &lsquo;<samp>4.3</samp>&rsquo; represents two modifiers,
# discussed in the next subsection.)
# &lsquo;<samp>%E</samp>&rsquo; uses &lsquo;<samp>E</samp>&rsquo; instead of &lsquo;<samp>e</samp>&rsquo; in the output.
# </p>
# </dd>
# <dt><code>%f</code></dt>
# <dd><p>Print a number in floating-point notation.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4.3f&quot;, 1950
# </pre></div>
# 
# <p>prints &lsquo;<samp>1950.000</samp>&rsquo;, with a minimum of four significant figures, three of
# which follow the decimal point.
# (The &lsquo;<samp>4.3</samp>&rsquo; represents two modifiers,
# discussed in the next subsection.)
# </p>
# <p>On systems supporting IEEE 754 floating-point format, values
# representing negative
# infinity are formatted as
# &lsquo;<samp>-inf</samp>&rsquo; or &lsquo;<samp>-infinity</samp>&rsquo;,
# and positive infinity as
# &lsquo;<samp>inf</samp>&rsquo; or &lsquo;<samp>infinity</samp>&rsquo;.
# The special &ldquo;not a number&rdquo; value formats as &lsquo;<samp>-nan</samp>&rsquo; or &lsquo;<samp>nan</samp>&rsquo;
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Strange-values.html">Floating Point Values They Didn&rsquo;t Talk About In School</a>).
# </p>
# </dd>
# <dt><code>%F</code></dt>
# <dd><p>Like &lsquo;<samp>%f</samp>&rsquo;, but the infinity and &ldquo;not a number&rdquo; values are spelled
# using uppercase letters.
# </p>
# <p>The &lsquo;<samp>%F</samp>&rsquo; format is a POSIX extension to ISO C; not all systems
# support it.  On those that don&rsquo;t, <code>gawk</code> uses &lsquo;<samp>%f</samp>&rsquo; instead.
# </p>
# </dd>
# <dt><code>%g</code>, <code>%G</code></dt>
# <dd><p>Print a number in either scientific notation or in floating-point
# notation, whichever uses fewer characters; if the result is printed in
# scientific notation, &lsquo;<samp>%G</samp>&rsquo; uses &lsquo;<samp>E</samp>&rsquo; instead of &lsquo;<samp>e</samp>&rsquo;.
# </p>
# </dd>
# <dt><code>%o</code></dt>
# <dd><p>Print an unsigned octal integer
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Nondecimal_002dnumbers.html">Octal and Hexadecimal Numbers</a>).
# </p>
# </dd>
# <dt><code>%s</code></dt>
# <dd><p>Print a string.
# </p>
# </dd>
# <dt><code>%u</code></dt>
# <dd><p>Print an unsigned decimal integer.
# (This format is of marginal use, because all numbers in <code>awk</code>
# are floating point; it is provided primarily for compatibility with C.)
# </p>
# </dd>
# <dt><code>%x</code>, <code>%X</code></dt>
# <dd><p>Print an unsigned hexadecimal integer;
# &lsquo;<samp>%X</samp>&rsquo; uses the letters &lsquo;<samp>A</samp>&rsquo; through &lsquo;<samp>F</samp>&rsquo;
# instead of &lsquo;<samp>a</samp>&rsquo; through &lsquo;<samp>f</samp>&rsquo;
# (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Nondecimal_002dnumbers.html">Octal and Hexadecimal Numbers</a>).
# </p>
# </dd>
# <dt><code>%%</code></dt>
# <dd><p>Print a single &lsquo;<samp>%</samp>&rsquo;.
# This does not consume an
# argument and it ignores any modifiers.
# </p></dd>
# </dl>
# 
# <blockquote>
# <p><b>NOTE:</b> When using the integer format-control letters for values that are
# outside the range of the widest C integer type, <code>gawk</code> switches to
# the &lsquo;<samp>%g</samp>&rsquo; format specifier. If <samp>--lint</samp> is provided on the
# command line (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>), <code>gawk</code>
# warns about this.  Other versions of <code>awk</code> may print invalid
# values or do something else entirely.
# (d.c.)
# </p></blockquote>
# 
# <blockquote>
# <p><b>NOTE:</b> The IEEE 754 standard for floating-point arithmetic allows for special
# values that represent &ldquo;infinity&rdquo; (positive and negative) and values
# that are &ldquo;not a number&rdquo; (NaN).
# </p>
# <p>Input and output of these values occurs as text strings. This is
# somewhat problematic for the <code>awk</code> language, which predates
# the IEEE standard.  Further details are provided in
# <a href="https://www.gnu.org/software/gawk/manual/html_node/POSIX-Floating-Point-Problems.html">Standards Versus Existing Practice</a>; please see there.
# </p></blockquote>
# 
# 
# <br>
# <h3 class="subsection">Modifiers for <code>printf</code> Formats</h3>
# 
# <p>A format specification can also include <em>modifiers</em> that can control
# how much of the item&rsquo;s value is printed, as well as how much space it gets.
# The modifiers come between the &lsquo;<samp>%</samp>&rsquo; and the format-control letter.
# We use the bullet symbol &ldquo;&bull;&rdquo; in the following examples to
# represent
# spaces in the output. Here are the possible modifiers, in the order in
# which they may appear:
# </p>
# <dl compact="compact">
# <dd>
# </dd>
# <dt><code><var>N</var>$</code></dt>
# <dd><p>An integer constant followed by a &lsquo;<samp>$</samp>&rsquo; is a <em>positional specifier</em>.
# Normally, format specifications are applied to arguments in the order
# given in the format string.  With a positional specifier, the format
# specification is applied to a specific argument, instead of what
# would be the next argument in the list.  Positional specifiers begin
# counting with one. Thus:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%s %s\n&quot;, &quot;don't&quot;, &quot;panic&quot;
# printf &quot;%2$s %1$s\n&quot;, &quot;panic&quot;, &quot;don't&quot;
# </pre></div>
# 
# <p>prints the famous friendly message twice.
# </p>
# <p>At first glance, this feature doesn&rsquo;t seem to be of much use.
# It is in fact a <code>gawk</code> extension, intended for use in translating
# messages at runtime.
# See <a href="https://www.gnu.org/software/gawk/manual/html_node/Printf-Ordering.html">Rearranging <code>printf</code> Arguments</a>,
# which describes how and why to use positional specifiers.
# For now, we ignore them.
# </p>
# </dd>
# <dt><code>-</code> (Minus)</span></dt>
# <dd><p>The minus sign, used before the width modifier (see later on in
# this list),
# says to left-justify
# the argument within its specified width.  Normally, the argument
# is printed right-justified in the specified width.  Thus:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%-4s&quot;, &quot;foo&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>foo&bull;</samp>&rsquo;.
# </p>
# </dd>
# <dt><span><var>space</var></span></dt>
# <dd><p>For numeric conversions, prefix positive values with a space and
# negative values with a minus sign.
# </p>
# </dd>
# <dt><code>+</code></dt>
# <dd><p>The plus sign, used before the width modifier (see later on in
# this list),
# says to always supply a sign for numeric conversions, even if the data
# to format is positive. The &lsquo;<samp>+</samp>&rsquo; overrides the space modifier.
# </p>
# </dd>
# <dt><code>#</code></dt>
# <dd><p>Use an &ldquo;alternative form&rdquo; for certain control letters.
# For &lsquo;<samp>%o</samp>&rsquo;, supply a leading zero.
# For &lsquo;<samp>%x</samp>&rsquo; and &lsquo;<samp>%X</samp>&rsquo;, supply a leading &lsquo;<samp>0x</samp>&rsquo; or &lsquo;<samp>0X</samp>&rsquo; for
# a nonzero result.
# For &lsquo;<samp>%e</samp>&rsquo;, &lsquo;<samp>%E</samp>&rsquo;, &lsquo;<samp>%f</samp>&rsquo;, and &lsquo;<samp>%F</samp>&rsquo;, the result always
# contains a decimal point.
# For &lsquo;<samp>%g</samp>&rsquo; and &lsquo;<samp>%G</samp>&rsquo;, trailing zeros are not removed from the result.
# </p>
# </dd>
# <dt><code>0</code></dt>
# <dd><p>A leading &lsquo;<samp>0</samp>&rsquo; (zero) acts as a flag indicating that output should be
# padded with zeros instead of spaces.
# This applies only to the numeric output formats.
# This flag only has an effect when the field width is wider than the
# value to print.
# </p>
# </dd>
# <dt><code>'</code></dt>
# <dd><p>A single quote or apostrophe character is a POSIX extension to ISO C.
# It indicates that the integer part of a floating-point value, or the
# entire part of an integer decimal value, should have a thousands-separator
# character in it.  This only works in locales that support such characters.
# For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">$ <kbd>cat thousands.awk</kbd>          <i>Show source program</i>
# -| BEGIN { printf &quot;%'d\n&quot;, 1234567 }
# $ <kbd>LC_ALL=C gawk -f thousands.awk</kbd>
# -| 1234567                   <i>Results in</i> &quot;C&quot; <i>locale</i>
# $ <kbd>LC_ALL=en_US.UTF-8 gawk -f thousands.awk</kbd>
# -| 1,234,567                 <i>Results in US English UTF locale</i>
# </pre></div>
# 
# <p>For more information about locales and internationalization issues,
# see <a href="https://www.gnu.org/software/gawk/manual/html_node/Locales.html">Where You Are Makes a Difference</a>.
# </p>
# <blockquote>
# <p><b>NOTE:</b> The &lsquo;<samp>'</samp>&rsquo; flag is a nice feature, but its use complicates things: it
# becomes difficult to use it in command-line programs.  For information
# on appropriate quoting tricks, see <a href="https://www.gnu.org/software/gawk/manual/html_node/Quoting.html">Shell Quoting Issues</a>.
# </p></blockquote>
# 
# </dd>
# <dt><span><var>width</var></span></dt>
# <dd><p>This is a number specifying the desired minimum width of a field.  Inserting any
# number between the &lsquo;<samp>%</samp>&rsquo; sign and the format-control character forces the
# field to expand to this width.  The default way to do this is to
# pad with spaces on the left.  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4s&quot;, &quot;foo&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>&bull;foo</samp>&rsquo;.
# </p>
# <p>The value of <var>width</var> is a minimum width, not a maximum.  If the item
# value requires more than <var>width</var> characters, it can be as wide as
# necessary.  Thus, the following:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%4s&quot;, &quot;foobar&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>foobar</samp>&rsquo;.
# </p>
# <p>Preceding the <var>width</var> with a minus sign causes the output to be
# padded with spaces on the right, instead of on the left.
# </p>
# </dd>
# <dt><code>.<var>prec</var></code></dt>
# <dd><p>A period followed by an integer constant
# specifies the precision to use when printing.
# The meaning of the precision varies by control letter:
# </p>
# <dl compact="compact">
# <dt><code>%d</code>, <code>%i</code>, <code>%o</code>, <code>%u</code>, <code>%x</code>, <code>%X</code></dt>
# <dd><p>Minimum number of digits to print.
# </p>
# </dd>
# <dt><code>%e</code>, <code>%E</code>, <code>%f</code>, <code>%F</code></dt>
# <dd><p>Number of digits to the right of the decimal point.
# </p>
# </dd>
# <dt><code>%g</code>, <code>%G</code></dt>
# <dd><p>Maximum number of significant digits.
# </p>
# </dd>
# <dt><code>%s</code></dt>
# <dd><p>Maximum number of characters from the string that should print.
# </p></dd>
# </dl>
# 
# <p>Thus, the following:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">printf &quot;%.4s&quot;, &quot;foobar&quot;
# </pre></div>
# 
# <p>prints &lsquo;<samp>foob</samp>&rsquo;.
# </p></dd>
# </dl>
# 
# <p>The C library <code>printf</code>&rsquo;s dynamic <var>width</var> and <var>prec</var>
# capability (e.g., <code>&quot;%*.*s&quot;</code>) is supported.  Instead of
# supplying explicit <var>width</var> and/or <var>prec</var> values in the format
# string, they are passed in the argument list.  For example:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">w = 5
# p = 3
# s = &quot;abcdefg&quot;
# printf &quot;%*.*s\n&quot;, w, p, s
# </pre></div>
# 
# <p>is exactly equivalent to:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">s = &quot;abcdefg&quot;
# printf &quot;%5.3s\n&quot;, s
# </pre></div>
# 
# <p>Both programs output &lsquo;<samp>&bull;&bull;abc<!-- /@w --></samp>&rsquo;.
# Earlier versions of <code>awk</code> did not support this capability.
# If you must use such a version, you may simulate this feature by using
# concatenation to build up the format string, like so:
# </p>
# <div class="example" style="border: 1px dashed #888888; padding-left: 5px">
# <pre class="example">w = 5
# p = 3
# s = &quot;abcdefg&quot;
# printf &quot;%&quot; w &quot;.&quot; p &quot;s\n&quot;, s
# </pre></div>
# 
# <p>This is not particularly easy to read, but it does work.
# </p>
# <p>C programmers may be used to supplying additional modifiers (&lsquo;<samp>h</samp>&rsquo;,
# &lsquo;<samp>j</samp>&rsquo;, &lsquo;<samp>l</samp>&rsquo;, &lsquo;<samp>L</samp>&rsquo;, &lsquo;<samp>t</samp>&rsquo;, and &lsquo;<samp>z</samp>&rsquo;) in <code>printf</code>
# format strings. These are not valid in <code>awk</code>.  Most <code>awk</code>
# implementations silently ignore them.  If <samp>--lint</samp> is provided
# on the command line (see <a href="https://www.gnu.org/software/gawk/manual/html_node/Options.html">Command-Line Options</a>), <code>gawk</code> warns about their
# use. If <samp>--posix</samp> is supplied, their use is a fatal error.
# </p>
# 
function stmt::printf() {}

# <dt><code>getline</code></dt>
# <br>
# <p>The <code class="code">getline</code> command returns 1 if it finds a record and 0 if
# it encounters the end of the file.  If there is some error in getting
# a record, such as a file that cannot be opened, then <code class="code">getline</code>
# returns &minus;1.  In this case, <code class="command">gawk</code> sets the variable
# <code class="code">ERRNO</code> to a string describing the error that occurred.
# </p>
# <table class="multitable">
# <thead><tr><th width="33%">Variant</th><th width="38%">Effect</th><th width="27%"><code class="command">awk</code> / <code class="command">gawk</code></th></tr></thead>
# <tbody><tr><td width="33%"><code class="code">getline</code></td><td width="38%">Sets <code class="code">$0</code>, <code class="code">NF</code>, <code class="code">FNR</code>, <code class="code">NR</code>, and <code class="code">RT</code></td><td width="27%"><code class="command">awk</code></td></tr>
# <tr><td width="33%"><code class="code">getline</code> <var class="var">var</var></td><td width="38%">Sets <var class="var">var</var>, <code class="code">FNR</code>, <code class="code">NR</code>, and <code class="code">RT</code></td><td width="27%"><code class="command">awk</code></td></tr>
# <tr><td width="33%"><code class="code">getline &lt;</code> <var class="var">file</var></td><td width="38%">Sets <code class="code">$0</code>, <code class="code">NF</code>, and <code class="code">RT</code></td><td width="27%"><code class="command">awk</code></td></tr>
# <tr><td width="33%"><code class="code">getline <var class="var">var</var> &lt; <var class="var">file</var></code></td><td width="38%">Sets <var class="var">var</var> and <code class="code">RT</code></td><td width="27%"><code class="command">awk</code></td></tr>
# <tr><td width="33%"><var class="var">command</var> <code class="code">| getline</code></td><td width="38%">Sets <code class="code">$0</code>, <code class="code">NF</code>, and <code class="code">RT</code></td><td width="27%"><code class="command">awk</code></td></tr>
# <tr><td width="33%"><var class="var">command</var> <code class="code">| getline</code> <var class="var">var</var></td><td width="38%">Sets <var class="var">var</var> and <code class="code">RT</code></td><td width="27%"><code class="command">awk</code></td></tr>
# <tr><td width="33%"><var class="var">command</var> <code class="code">|&amp; getline</code></td><td width="38%">Sets <code class="code">$0</code>, <code class="code">NF</code>, and <code class="code">RT</code></td><td width="27%"><code class="command">gawk</code></td></tr>
# <tr><td width="33%"><var class="var">command</var> <code class="code">|&amp; getline</code> <var class="var">var</var></td><td width="38%">Sets <var class="var">var</var> and <code class="code">RT</code></td><td width="27%"><code class="command">gawk</code></td></tr>
# </tbody>
# </table>
function stmt::getline() {}
