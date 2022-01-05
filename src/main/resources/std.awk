BEGIN { }

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
function awk::gsub() {}