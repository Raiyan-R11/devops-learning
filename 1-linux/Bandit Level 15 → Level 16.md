## Bandit Level 15 → Level 16

**Challenge:**
The password for the next level can be retrieved by submitting the password of the current level to **port 30001 on localhost** using SSL/TLS encryption.

**Solution:**

```bash
openssl s_client -connect localhost:30001
```

**Explanation:**

- `openssl`

**What I learned:**
