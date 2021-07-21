
### Goals

- "Global" variables resolution. This means that it's desirable that variable defined in one file should be linked to usage of it in other file.
- From the other side we don't want that single-file scripts suffer from contamination by variables defined in other unrelated files.

Obviously, the two goals above conflict with each other.

### Declaration-like cases

- `Var = ...`
- `split("",Arr)` - awk idiomatic way to define empty array
- `Arr["key"] = ...`
- `Arr["key"]`

#### To be considered

- variable usages starting capital-case: `Var`
- special treatment for variable occurrences in `BEGIN` blocks?

### Let's implement next heuristic (in order of attempt):

1. resolve current function argument
2. resolve **Declaration-like cases** in current file
3. resolve **Declaration-like cases** in other files (= in all files)
4. resolve `Var` across all files