## Bandit Level 18 → Level 19

**Challenge:**
The password for the next level is stored in a file **readme** in the homedirectory. Unfortunately, someone has modified **.bashrc** to log you out when you log in with SSH.

**Solution:**

```bash
ssh bandit18@bandit.labs.overthewire.org -p2220 "cat readme"
```

**Explanation:**

- `ssh` with a command to run `cat readme` immeadiatly after logging in.

**What I learned:** commands can be run directly via ssh
