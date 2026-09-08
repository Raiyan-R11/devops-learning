## Bandit Level 14 → Level 15

**Challenge:**
The password for the next level can be retrieved by submitting the password of the current level to **port 30000 on localhost**.

**Solution:**

```bash
nc localhost 30000
aaWecNkG4FhxJQxz07uiwzVP6bJiYS65 <password of the prev level>
```

**Explanation:**

- `nc` tool is used to open a connection to port 30000 , to send plain text password of level 13. Level 14 password was recieved in return as plain text output

**What I learned:** `nc` is a utility tool using netcat protol (**no encryption in transit**).
Used for all purposes for TCP, UDP, or Unix-domain sockets.
Allows to send packets, open ports, etc.
Useful to test ports and see how a service reacts.
