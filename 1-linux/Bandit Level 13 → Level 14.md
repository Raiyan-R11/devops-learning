## Bandit Level 13 → Level 14

**Challenge:**
The password for the next level is stored in **/etc/bandit_pass/bandit14 and can only be read by user bandit14**. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Look at the commands that logged you into previous bandit levels, and find out how to use the key for this level.  
If you need help with this level: a hint file can be found in the home directory.  
Make sure to read the error messages as they are informative.

**Solution:**

```bash
scp -P 2220 bandit13@bandit.labs.overthewire.org:/home/bandit13/sshkey.private ~/bandit14key
chmod 600 ~/bandit14key
ssh -i ~/bandit14key bandit14@bandit.labs.overthewire.org -p 2220

```

**Explanation:**

- `scp` allows to copy files between hosts in a network.
  - Done from local shell. Copied the key from OTW `/home` to my local `~/`
- `ssh -i` allows to use the copied private key to login

**What I learned:** `scp` allows to move files between machines using the SFTP protocol.
