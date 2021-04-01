# intellij-awk

[WiP] The missing IntelliJ IDEA language support plugin for [AWK](https://en.wikipedia.org/wiki/AWK)

## Motivation

- At the moment there is no AWK plugin for IDEA, which is a pity.
- Interested to sharpen my Java skills and learn some IDEA internals.

## Goals v0.0.1

- Support basic AWK code highlighting
- Support basic AWK code navigations (go to declaration, show structure)
- Support only POSIX subset (aka BWK), w/o Gawk additions (this can be added later)

## Goals v0.0.2

- Showing documentation for built-in functions
- Showing documentation for built-in variables (`NR`/`NF`/etc.)

## Goals v0.0.3

- Refactoring support
    - rename variable
    - rename function
- Enforce variable naming convention
    - `Name` for global
    - `name` for local
    
## Future ideas

- Auto-format code via `gawk --pretty-print`

## Useful links

- BWK https://github.com/onetrueawk/awk
- [Custom language support JetBrains tutorial](https://plugins.jetbrains.com/docs/intellij/custom-language-support.html)
- Grammar:
    - [AWK Grammar in Yacc from BWK](https://github.com/onetrueawk/awk/blob/master/awkgram.y)
    - [AWK Grammar in Yacc from Gawk](http://git.savannah.gnu.org/cgit/gawk.git/tree/awkgram.y)
    - https://slebok.github.io/zoo/#awk
        - [EBNF Grammar](https://github.com/slebok/zoo/blob/master/zoo/awk/manual/fetched/src.grammar.txt)
        - https://pubs.opengroup.org/onlinepubs/7908799/xcu/awk.html#tag_000_000_108_016
- Some other language plugins
    - [Zig](https://github.com/ice1000/intellij-zig)
    - [Solidity](https://github.com/intellij-solidity/intellij-solidity)
    - [Erlang](https://github.com/ignatov/intellij-erlang)
    - [Elixir](https://github.com/KronicDeth/intellij-elixir)
    - [Rust](https://github.com/intellij-rust/intellij-rust)
    - [Bash](https://github.com/BashSupport/BashSupport)
    - [Zephir](https://github.com/zephir-lang/idea-plugin)
    - [IDEA sh](https://github.com/JetBrains/intellij-community/tree/master/plugins/sh)
    - [IDEA properties](https://github.com/JetBrains/intellij-community/tree/master/plugins/properties) 
