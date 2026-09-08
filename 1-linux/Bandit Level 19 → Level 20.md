## Bandit Level 19 → Level 20

**Challenge:**
To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

**Solution:**

```bash
bandit19@bandit:~$ ls
bandit20-do
bandit19@bandit:~$ ls -l
total 16
-rwsr-x--- 1 bandit20 bandit19 14880 Jun 24 14:58 bandit20-do
bandit19@bandit:~$ ./bandit20-do
Run a command as another user.
  Example: ./bandit20-do whoami
bandit19@bandit:~$ ./bandit20-do whoami
bandit20
bandit19@bandit:~$ cd /etc/bandit_pass/
bandit19@bandit:/etc/bandit_pass$ cat bandit20
cat: bandit20: Permission denied
bandit19@bandit:/etc/bandit_pass$ ~/bandit20-do cat bandit20
4pIjcunZ0fK2vmp3IwfG8Vf7VhxD6pOA
```

**Explanation:**

- ran a binary `bandit20-do`
- its file permissions reveal `rws` for owner
- binary runs commands with privilages of file owner.

**What I learned:** setuid bit `s` instead of `x` in owner permissions, allow the program to run with the privileges of the owner(bandit20) instead of the privileges of whoever launched it(bandit19).
