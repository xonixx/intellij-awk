
### Goals

- "Global" variables resolution. This means that it's desirable that variable defined in one file should be linked to usage of it in other file. Example: go to declaration, find all usages, auto-completion.
- From the other side we don't want that single-file scripts suffer from contamination by variables defined in other unrelated files.

Obviously, the two goals above conflict with each other. We need to come up with good heuristics to handle both cases acceptably good and/or provide a way to structure a code in a way to hint the intellij-awk for desired behavior.

### Considerations

- variable usages starting capital-case: `Var`. Usually thhis denotes global variable.
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
2. resolve *any variable occurrence* in current file in **Initializing context** `// RESOLVE-ANY-CUR-INIT`
   - **why** this is backward-compatible
3. resolve **Declaration-like cases** in other files (= in all project files) in **Initializing context** `// RESOLVE-DECL-ALL-INIT`
4. resolve **Declaration-like cases** in other files (= in all project files) `// RESOLVE-DECL-ALL`
5. resolve *any variable occurrence* across all files `// RESOLVE-ANY-VAR`
   - **todo** this should exclude variables that resolve to function arguments

### TODO

1. Handle `match(ARGV[pos], /^--?show-original(=(.*)?)?$/, group)` case
2. **idea** resolve `Option["opt_name"]` to `Option["opt_name"] = ...` 