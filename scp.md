# 📁 SCP Command — Complete Guide

> **SCP (Secure Copy Protocol)** is a command-line tool used to securely transfer files and directories between a local machine and a remote server (or between two remote servers) over SSH.

---

## 📌 Table of Contents

- [What is SCP?](#what-is-scp)
- [Basic Syntax](#basic-syntax)
- [Common Options / Flags](#common-options--flags)
- [Upload: Local → Remote](#upload-local--remote)
  - [Single File](#-upload-single-file)
  - [Single Folder](#-upload-single-folder)
  - [Multiple Files](#-upload-multiple-files)
  - [Multiple Folders](#-upload-multiple-folders)
- [Download: Remote → Local](#download-remote--local)
  - [Single File](#-download-single-file)
  - [Single Folder](#-download-single-folder)
  - [Multiple Files](#-download-multiple-files)
  - [Multiple Folders](#-download-multiple-folders)
- [Remote → Remote Transfer](#remote--remote-transfer)
- [Using SSH Key Instead of Password](#using-ssh-key-instead-of-password)
- [Using Custom SSH Port](#using-custom-ssh-port)
- [Practical Examples](#practical-examples)
- [Tips & Best Practices](#tips--best-practices)

---

## What is SCP?

SCP stands for **Secure Copy Protocol**. It uses **SSH (Secure Shell)** under the hood to encrypt both authentication and data during transfer — making it safe for transferring sensitive files over networks.

### Key Features:
- ✅ Encrypted file transfer via SSH
- ✅ Works on Linux, macOS, and Windows (via WSL or Git Bash)
- ✅ Supports files, folders, and wildcards
- ✅ No extra software needed — comes pre-installed on most Unix systems

---

## Basic Syntax

```bash
scp [OPTIONS] SOURCE DESTINATION
```

| Part          | Description                                      |
|---------------|--------------------------------------------------|
| `OPTIONS`     | Flags like `-r`, `-P`, `-i`, `-v`, etc.          |
| `SOURCE`      | The file/folder you want to copy (from)          |
| `DESTINATION` | Where you want to copy it (to)                   |

**Remote path format:**
```
user@host:/path/to/destination
```

---

## Common Options / Flags

| Flag        | Description                                              |
|-------------|----------------------------------------------------------|
| `-r`        | Recursively copy entire directories                      |
| `-P port`   | Specify a custom SSH port (capital P)                    |
| `-i key`    | Use a private SSH key file for authentication            |
| `-v`        | Verbose mode — show detailed transfer progress           |
| `-q`        | Quiet mode — suppress progress output                    |
| `-C`        | Enable compression during transfer                       |
| `-l limit`  | Limit bandwidth (in Kbit/s)                              |
| `-p`        | Preserve file timestamps and permissions                 |

---

## Upload: Local → Remote

### 📄 Upload Single File

```bash
scp /local/path/file.txt user@remote_host:/remote/path/
```

**Example:**
```bash
scp report.pdf john@192.168.1.10:/home/john/documents/
```

---

### 📂 Upload Single Folder

Use the `-r` flag to copy a directory recursively.

```bash
scp -r /local/path/folder user@remote_host:/remote/path/
```

**Example:**
```bash
scp -r /home/user/projects john@192.168.1.10:/home/john/
```

> This copies the entire `projects` folder into `/home/john/` on the remote server.

---

### 📄📄 Upload Multiple Files

List multiple files separated by spaces:

```bash
scp file1.txt file2.txt file3.txt user@remote_host:/remote/path/
```

**Example:**
```bash
scp index.html style.css app.js john@192.168.1.10:/var/www/html/
```

Or use a **wildcard** to match files:

```bash
scp *.txt user@remote_host:/remote/path/
scp *.log john@192.168.1.10:/home/john/logs/
```

---

### 📂📂 Upload Multiple Folders

```bash
scp -r folder1 folder2 folder3 user@remote_host:/remote/path/
```

**Example:**
```bash
scp -r src/ assets/ config/ john@192.168.1.10:/home/john/myapp/
```

---

## Download: Remote → Local

### 📄 Download Single File

```bash
scp user@remote_host:/remote/path/file.txt /local/path/
```

**Example:**
```bash
scp john@192.168.1.10:/home/john/backup.zip /home/user/Downloads/
```

---

### 📂 Download Single Folder

```bash
scp -r user@remote_host:/remote/path/folder /local/path/
```

**Example:**
```bash
scp -r john@192.168.1.10:/home/john/projects /home/user/Desktop/
```

---

### 📄📄 Download Multiple Files

```bash
scp user@remote_host:"/remote/path/{file1.txt,file2.txt,file3.txt}" /local/path/
```

> ⚠️ Wrap the remote path in **double quotes** when using `{}` brace expansion.

**Example:**
```bash
scp john@192.168.1.10:"/home/john/{notes.txt,report.pdf,data.csv}" /home/user/Downloads/
```

Or using wildcards:

```bash
scp "john@192.168.1.10:/home/john/logs/*.log" /home/user/logs/
```

---

### 📂📂 Download Multiple Folders

```bash
scp -r user@remote_host:"/remote/path/{folder1,folder2}" /local/path/
```

**Example:**
```bash
scp -r john@192.168.1.10:"/home/john/{projects,backups}" /home/user/Desktop/
```

---

## Remote → Remote Transfer

You can copy files directly between two remote servers:

```bash
scp user1@remote1:/path/file.txt user2@remote2:/path/
```

**Example:**
```bash
scp john@server1.com:/home/john/db_backup.sql root@server2.com:/var/backups/
```

---

## Using SSH Key Instead of Password

```bash
scp -i /path/to/private_key file.txt user@remote_host:/remote/path/
```

**Example:**
```bash
scp -i ~/.ssh/id_rsa report.pdf john@192.168.1.10:/home/john/
```

> Use SSH keys for passwordless, automated, and more secure transfers.

---

## Using Custom SSH Port

By default, SCP uses port **22**. To use a different port:

```bash
scp -P 2222 file.txt user@remote_host:/remote/path/
```

**Example:**
```bash
scp -P 2222 -r /local/folder john@192.168.1.10:/home/john/
```

> ⚠️ Note: It's **uppercase `-P`** for SCP (unlike SSH which uses lowercase `-p`).

---

## Practical Examples

### Deploy a website to a server
```bash
scp -r ./build/ ubuntu@myserver.com:/var/www/html/
```

### Download a database backup from server
```bash
scp root@myserver.com:/var/backups/db_backup.sql ~/Desktop/
```

### Upload config files to a remote server
```bash
scp .env nginx.conf docker-compose.yml ubuntu@myserver.com:/home/ubuntu/app/
```

### Upload with compression (faster on slow networks)
```bash
scp -C -r ./large-folder john@192.168.1.10:/home/john/
```

### Download all `.log` files from remote
```bash
scp "root@myserver.com:/var/log/*.log" ~/logs/
```

### Upload to a non-standard SSH port with private key
```bash
scp -P 2222 -i ~/.ssh/my_key -r ./project user@myserver.com:/home/user/
```

---

## Tips & Best Practices

| Tip | Description |
|-----|-------------|
| 🔑 Use SSH Keys | Avoid typing passwords every time — set up key-based auth |
| 🗜️ Use `-C` for large files | Compression speeds up transfers on slow connections |
| 📋 Use `-v` for debugging | Verbose mode shows exactly what's happening step by step |
| 🔁 Use `rsync` for syncing | For incremental/resumable transfers, prefer `rsync` over `scp` |
| 🛡️ Verify host fingerprint | On first connection, confirm the host fingerprint to avoid MITM attacks |
| 📁 Trailing slash matters | `scp file user@host:/dir/` copies file *into* the dir; without slash may rename it |

---

## Quick Reference Cheat Sheet

```
# Upload file
scp file.txt user@host:/remote/path/

# Upload folder
scp -r folder/ user@host:/remote/path/

# Upload multiple files
scp file1 file2 file3 user@host:/remote/path/

# Download file
scp user@host:/remote/path/file.txt /local/path/

# Download folder
scp -r user@host:/remote/path/folder /local/path/

# Download multiple files
scp user@host:"/remote/{file1,file2}" /local/path/

# Custom port
scp -P 2222 file.txt user@host:/remote/path/

# Use SSH key
scp -i ~/.ssh/id_rsa file.txt user@host:/remote/path/
```

---

> 💡 **Pro Tip:** For large or interrupted transfers, consider using `rsync -avz --progress` instead of `scp` — it supports resume and only transfers changed files.
