
## Parser quirks

Due to very ad-hoc nature of AWK syntax (namely some inherent ambiguities in its grammar) the implemented IntelliJ IDEA AWK parser has some minor limitations.

If you find any of them too limiting, please file an issue with description of your use-case.

### Glossary

- **ERE** - Extended regular expressions - [the form of regexes](https://en.wikipedia.org/wiki/Regular_expression#Standards) supported by AWK

### 1. Unescaped `/` inside ERE class (ex.: `/[/]/`)

[Related issue](https://github.com/xonixx/intellij-awk/issues/60)
                                             
It appears Gawk parser is more permissive here compared to other AWK implementations:

```
$ gawk51 'BEGIN { print "a/aa" ~ /a[/]/ }'
1
```
```
$ bwk 'BEGIN { print "a/aa" ~ /a[x/y]/ }'
./soft/bwk: nonterminated character class a[x
 source line number 1
 context is
        BEGIN { print "a/aa" ~ >>>  /a[x/ <<< 
```
```
$ mawk 'BEGIN { print "a/aa" ~ /a[x/y]/ }'
mawk: line 1: regular expression compile failed (bad class -- [], [^] or [)
a[x
mawk: line 1: syntax error at or near ]
```

The reason is because as `/` marks the start and end of ERE those other AWK implementations stop parsing the ERE after the second `/` encountered, thus parsing only `/a[x/` part as ERE.
Looks like Gawk has some [more complex logic](https://git.savannah.gnu.org/cgit/gawk.git/tree/awkgram.y?h=gawk-5.1.0#n3612) to parse regexes thus allowing more flexibility.

We are not able to parse EREs with same flexibility in Intellij Idea plugin, because we are limited with JFlex lexing capabilities. Thus if you happen to use this form of regexes - will cause error. 

#### Solution

Just escape the `/` (like this `/[\/]/`) and Idea AWK will parse it happily. Also you make your script more portable.

### 2. ERE vs DIV lexing ambiguity

[Related issue](https://github.com/xonixx/intellij-awk/issues/11)

The problem resides in lexing ambiguity of tokens `/regex/` vs `/`. Naturally, lexer prefers the longer term. This causes a problem for parsing a code like

```awk
a(1 / 2, 3 / 4)
```

Because it parses as `a(1 (/ 2, 3 /) 4)` instead of correct `a((1/2), (3/4))`.

Due to this our lexer was adjusted in such a way that it recognizes `/` in any position where it is syntactically possible in AWK. This makes the example above parse correctly.

However, this makes some other (rare) cases to parse incorrectly: 

```awk
{
    print 1 /=2/
}
```
*(Note, only Gawk considers this syntax correct, not mawk or bwk)* 

This will cause an error because it will try to recognise division in `1 /=2` part.

#### Solution

In case you'll need to use code similar to this just wrap the ERE in parentheses:
```awk
{
    print 1 (/=2/)
}
```

### 3. Gawk built-in functions shadowing

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

