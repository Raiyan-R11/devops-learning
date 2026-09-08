## Bandit Level 16 → Level 17

**Challenge:**
The credentials for the next level can be retrieved by submitting the password of the current level to **a port on localhost in the range 31000 to 32000**. First find out which of these ports have a server listening on them. Then find out which of those speak SSL/TLS and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

**Solution:**

```bash
nmap -p 31000-32000 localhost
<5 ports output>
nc localhost <test each port> //enter text, if echos then ignore
echo "<bandit16 password>" | openssl s_client -connect localhost:<port that did not echo in nc> -quiet 2>/dev/null
```

**Explanation:**

- `openssl`

**What I learned:**
Permissions 0644 for '/home/raiyanr/17key.txt' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
``
