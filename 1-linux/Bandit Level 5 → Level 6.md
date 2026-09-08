## Bandit Level 5 → Level 6

**Challenge:** Find a file with these properties:

- Human-readable
- 1033 bytes in size
- Not executable

**Solution:**

```bash
find . -type f -size 1033c ! -executable -exec file {} \; | grep text
cat ./maybehere07/.file2
```

**Explanation:**

- `find . -type f -size 1033c` searches for files exactly 1033 bytes
- `! -executable` excludes executable files
- `-exec file {} \;` runs `file` command on each result
- `grep text` filters for human-readable files

**What I learned:** The `find` command is incredibly powerful for filtering files by multiple properties.
