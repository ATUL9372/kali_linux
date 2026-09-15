# WireGuard Tunnel Setup Guide

Complete step-by-step setup guide for configuring a secure WireGuard VPN tunnel between the Server 1(ubuntu) is main server soc and the Server 2(kali).

## Network Overview

| Role | Hostname | Public IP | Private Tunnel IP | WireGuard Port |
|---|---|---|---|---|
| Server 1 (ubuntu)soc | ubuntu@HostName | 1.1x.xx.44 | 10.0.0.1/24 | 51820 (UDP) |
| Server 2 (kali)   | kali@HostName   | 2.x6.68.xx | 10.0.0.2/24 | Dynamic |

---

## Part A: Setup on Server 1 (ubuntu)

### 1. Install WireGuard

```bash
sudo apt update && sudo apt install -y wireguard
sudo su
cd /etc/wireguard/
```

### 2. Generate Private and Public Keys

```bash
umask 077
sudo wg genkey | sudo tee privatekey | sudo wg pubkey | sudo tee publickey

# View generated keys
sudo cat privatekey
sudo cat publickey
```

### 3. Create Configuration File (`/etc/wireguard/wg0.conf`)

Create or edit the file:

```bash
sudo nano /etc/wireguard/wg0.conf
```

Paste the following content:

```ini
[Interface]
# Private IP address assigned to Server 1(ubuntu) inside the WireGuard tunnel
Address = 10.0.0.1/24
# The UDP port WireGuard will listen on for incoming client connections
ListenPort = 51820
# Private Key of Server 1(ubuntu)
PrivateKey = <PASTE_SERVER1(ubuntu)_PRIVATE_KEY_HERE>

# ==========================================
# Peer Section: Server 2(kali) (Agent)
# ==========================================
[Peer]
# Public Key of Server 2(ubuntu) (generated on Server 2)
PublicKey = <PASTE_SERVER2(kali)_PUBLIC_KEY_HERE>
# Allowed internal IP address range for Server 2 (kali)inside the VPN
AllowedIPs = 10.0.0.2/32
```

### 4. Configure Firewall & Start Service

```bash
# Allow UDP port 51820 through UFW
sudo ufw allow 51820/udp
sudo ufw reload

# Start the interface
sudo wg-quick up wg0

# Enable automatic start on system boot
sudo systemctl enable wg-quick@wg0

sudo wg
ip a
```

---

## Part B: Setup on Server 2(kali) agent

### 1. Install WireGuard

```bash
sudo apt update && sudo apt install -y wireguard
sudo su
```

### 2. Generate Private and Public Keys

```bash
cd /etc/wireguard
umask 077
wg genkey | tee privatekey | wg pubkey > publickey
```
### 3. Check generate *.key
```bash
ls -l privatekey publickey
```

### 4. Create Configuration File (`/etc/wireguard/wg0.conf`)

Create or edit the file:

```bash
sudo nano /etc/wireguard/wg0.conf
```

Paste the following content:

```ini
[Interface]
# Private IP address assigned to Server 1(ubuntu) inside the WireGuard tunnel
Address = 10.0.0.2/24
# Private Key of Server 2(kali) agent
PrivateKey = <PASTE_SERVER2(kali)_PRIVATE_KEY_HERE>

# ==========================================
# Peer Section: Server 1(ubuntu)
# ==========================================
[Peer]
# Public Key of Server 1 (generated on Server ubuntu)
PublicKey = <PASTE_SERVER1(ubuntu)_PUBLIC_KEY_HERE>
# Public Endpoint address and listening port of Server 1(ubuntu)  
Endpoint = 1.1x.xx.44:51820   # enter here server1(ubuntu) public ip address
# Allowed IP routing range for Server 1(ubuntu) inside the VPN
AllowedIPs = 10.0.0.1/32
# Sends keep-alive packets every 25 seconds to keep the tunnel active through NAT/firewalls
PersistentKeepalive = 25
```

### 5. Start WireGuard Service

```bash
# Start the interface
sudo wg-quick up wg0

# Enable automatic start on system boot
sudo systemctl enable wg-quick@wg0

sudo wg
ip a
```

---

## Part C: Connectivity Verification

Run the following commands on either server to test status and connectivity:

```bash
# Check interface status and latest handshake
sudo wg

# Test tunnel connectivity from Server 1 to Server 2
ping 10.0.0.1

# Test tunnel connectivity from Server 2 to Server 1
ping 10.0.0.2
```
---

# WireGuard VPN Management Commands

Commands for managing, stopping, and restarting the WireGuard service on Linux systemd environments.

---

## 1. Quick Commands

| Action | Command |
| :--- | :--- |
| **Restart Service** | `sudo systemctl restart wg-quick@wg0` |
| **Stop Service** | `sudo systemctl stop wg-quick@wg0` |
| **Start Service** | `sudo systemctl start wg-quick@wg0` |
| **Check Status** | `sudo systemctl status wg-quick@wg0` |

---

## 2. Interface Level Commands (`wg-quick`)

If `systemctl` hangs or encounters errors, use `wg-quick` directly:

### Stop Interface
```bash
sudo wg-quick down wg0
```

### Start Interface
```bash
sudo wg-quick up wg0
```

---

## 3. Handling "`wg0 already exists`" Error

When restarting fails because the interface is stuck in an active state:

```bash
# Force-remove the stuck interface
sudo ip link delete wg0

# Clean restart via systemd
sudo systemctl restart wg-quick@wg0
```

---

## 4. Verification & Diagnostics

### View Active Configuration & Handshakes
```bash
sudo wg show
```

### Check Live Traffic / Logs
```bash
sudo journalctl -u wg-quick@wg0 -f
```

---

**Note:** Replace `wg0` with your specific configuration name if using a different interface file (e.g., `/etc/wireguard/wg1.conf` → `wg1`).


## Diagram
![image](https://github.com/ATUL9372/kali_linux/blob/cb62d574de3609aae4c8043ce5914b659647cb63/wireguard.png)

# Ubuntu GUI

# NetworkManager WireGuard Commands

A quick reference guide for managing WireGuard VPN connections using `nmcli` in Ubuntu/Linux.

---

## Command Reference

### 0. All in one
Here is how to set up NetworkManager control using the terminal.
```bash
sudo wg-quick up wg0
sudo nmcli connection import type wireguard file /etc/wireguard/wg0.conf
nmcli connection show
sudo wg-quick down wg0
ip a show wg0
nmcli connection show --active
```


### 1. Import Configuration
Import an existing WireGuard configuration file into NetworkManager:
```bash
sudo nmcli connection import type wireguard file /etc/wireguard/wg0.conf
```

### 2. Connect / Disconnect VPN
* **Connect:**
  ```bash
  nmcli connection up wg0
  ```
* **Disconnect:**
  ```bash
  nmcli connection down wg0
  ```

### 3. Manage Auto-Connect on Boot
* **Enable auto-connect:**
  ```bash
  nmcli connection modify wg0 connection.autoconnect yes
  ```
* **Disable auto-connect:**
  ```bash
  nmcli connection modify wg0 connection.autoconnect no
  ```

### 4. Delete Connection
Remove the WireGuard connection profile from NetworkManager:
```bash
nmcli connection delete wg0
```

---

## Status Verification

* **Check active connections:**
  ```bash
  nmcli connection show --active
  ```
* **Verify WireGuard status:**
  ```bash
  sudo wg show
  ```
