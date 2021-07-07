
## Parser quirks

### ERE vs DIV lexing ambiguity

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
    print 1 /hello/
}
```

This will cause an error because it will try to recognise division in `1 /hello` part.

In case you'll need to use code similar to this just wrap the ERE in parentheses:
```awk
{
    print 1 (/hello/)
}
```
