
### Declaration-like cases

- `Var = ...`
- `split("",Arr)` - awk idiomatic way to define empty array
- `Arr["key"] = ...`
- `Arr["key"]`

### Let's implement next heuristic (in order of attempt):

1. resolve current function argument
2. resolve **Declaration-like cases** in current file
3. resolve **Declaration-like cases** in other files (= in all files)
4. resolve `Var` across all files