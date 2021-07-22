
### Goals

- "Global" variables resolution. This means that it's desirable that variable defined in one file should be linked to usage of it in other file. Example: go to declaration, find all usages, auto-completion.
- From the other side we don't want that single-file scripts suffer from contamination by variables defined in other unrelated files.

Obviously, the two goals above conflict with each other. We need to come up with good heuristics to handle both cases acceptably good and/or provide a way to structure a code in a way to hint the intellij-awk for desired behavior.

### Considerations

- variable usages starting capital-case: `Var`. Usually this denotes global variable.
  - **resolution** let's not rely on this to be more universal

### Declaration-like cases

- `Var = ...`
- `split("",Arr)` - awk idiomatic way to define empty array
- `Arr["key"] = ...`
- `Arr["key"]`

### Initializing context

- variable occurrences in `BEGIN` blocks
- variable occurrences in `init*()` functions

### Let's implement next heuristic (in order of attempt):

1. resolve current function argument `// RESOLVE-ARG`
2. resolve first of **Declaration-like cases** in current file in **Initializing context** `// RESOLVE-FIRST-CUR-INIT`
3. resolve first of **Declaration-like cases** in all project files in **Initializing context** `// RESOLVE-DECL-ALL-INIT`
4. resolve first of **Declaration-like cases** in current file `// RESOLVE-DECL-CUR`
5. resolve *first variable occurrence* in current file `// RESOLVE-FIRST-CUR`
   - **why** this is backward-compatible
   - cases like `BEGIN { while(getline Line) process() } function process() { print Line }`

Bottom line: we don't try to resolve global var in other files unless it looks like declaration in initialization context.

### TODO
                                                                       
1. **Global resolution should exclude variables that resolve to function arguments**
2. Handle `match(ARGV[pos], /^--?show-original(=(.*)?)?$/, group)` case
3. **idea** resolve `Option["opt_name"]` to `Option["opt_name"] = ...` 