# User and Group Management Commands

This README provides a quick reference for managing users and groups on a Linux system. The commands below cover essential tasks for user and group management.

---

## Steps and Commands

### 1. **Create a Group**
```bash
sudo groupadd groupname
```

---

### 2. **Assign Permissions to a Group**
#### Change File Ownership to a Group:
```bash
sudo chown :groupname filename
```

---

### 3. **Change Group Permissions on a File**
```bash
sudo chmod g+rwx filename
```
- `g+rwx`: Grants read, write, and execute permissions to the group.

---

### 4. **Set Group as Default Owner for New Files**
```bash
sudo chmod g+s directoryname
```

---

### 5. **Create a User with a Home Folder**
#### Using `useradd`:
```bash
sudo useradd -m username
```
- `-m`: Creates a home directory for the user.

#### Using `adduser`:
```bash
sudo adduser username
```
- Interactive command that also sets a password and creates a home directory.

---

### 6. **Add a User to a Group**
```bash
sudo usermod -aG groupname username
```
- `-aG`: Appends the user to the group without removing existing group memberships.

---

### 7. **Remove a User from a Group**
```bash
sudo gpasswd -d username groupname
```

---

## Notes
- Replace `username` and `groupname` with the actual user and group names.
- Ensure you have proper permissions (e.g., sudo privileges) to execute these commands.
