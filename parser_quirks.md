
## Parser quirks

Due to very ad-hoc nature of AWK syntax (namely some inherent ambiguities in its grammar) the implemented IntelliJ IDEA AWK parser has some minor limitations.

If you find any of them too limiting, please file an issue with description of your use-case.

### 1. ERE vs DIV lexing ambiguity

[Related issue](https://github.com/xonixx/intellij-awk/issues/11)

The problem resides in lexing ambiguity of tokens `/regex/` vs `/`. Naturally, lexer prefers the longer term. This causes a problem for parsing a code like

```awk
a(1 / 2, 3 / 4)
```

Because it parses as `a(1, (/ 2, 3 /) 4)` instead of correct `a((1/2), (3/4))`.

Due to this our lexer was adjusted in such a way that it recognizes `/` in any position where it is syntactically possible in AWK. This makes the example above parse correctly.

However, this makes some other (rare) cases to parse incorrectly: 

```awk
{
    print 1 /=2/
}
```
*(Note, only Gawk considers this syntax correct, not mawk or bwk)* 

This will cause an error because it will try to recognise division in `1 /hello` part.

In case you'll need to use code similar to this just wrap the ERE in parentheses:
```awk
{
    print 1 (/=2/)
}
```

### 2. Gawk built-in functions shadowing

[Related issue](https://github.com/xonixx/intellij-awk/issues/70)

Gawk has additional set of built-in functions (ex.: [bitwise functions](https://www.gnu.org/software/gawk/manual/html_node/Bitwise-Functions.html)) over standard Posix AWK built-in functions. What is interesting, looks like it differentiates standard built-in functions parsing vs additional functions. That is, built-in functions are always parsed as a part of syntax.
This makes 
```awk
function f(gsub) { print gsub }
```
invalid, since `gsub` is built-in function and so can't serve as parameter name.

However Gawk (5.1.0) allows
```awk
function f(and) { print and }
```
even though `and` is Gawk built-in function (but not standard one).

To keep parser simple we now treat all Gawk function similar to standard functions, thus disallowing the example above. This may be unfortunate, since it's valid Posix AWK code. We may ease this restriction in future.

