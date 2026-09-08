## Bandit Level 20 → Level 21

**Challenge:**
There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).

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
