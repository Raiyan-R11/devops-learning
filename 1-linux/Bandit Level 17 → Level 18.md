## Bandit Level 17 → Level 18

**Challenge:**
There are 2 files in the homedirectory: **passwords.old and passwords.new**. The password for the next level is in **passwords.new** and is the only line that has been changed between **passwords.old and passwords.new**

**Solution:**

```bash
diff passwords.new passwords.old
42c42
< OQxXZjELndr90zuhOTDYBEomI0SZITXI
---
> qOg5pVOjPx9x9VccyYBADiT4xxyoUB8D
```

**Explanation:**

- `diff passwords.new passwords.old` compares the two files line by line
- `42c42` means: **line 42 differs between the two files** ("c" = changed)
- Everything between `<` and `---` is the content **from the first file** you listed (`passwords.new`)
- Everything between `---` and the end is the content **from the second file** (`passwords.old`)

**What I learned:** `diff` can be a useful tool to check difference between config files
