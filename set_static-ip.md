# Setting up a Static IP Address on Ubuntu 24.04 LTS

This guide provides step-by-step instructions for configuring a static IP address (`192.168.1.180`) on Ubuntu 24.04 LTS using **Netplan**.

---

## Network Interface Overview

Based on system output:
* **Interface Name:** `enp0s3`
* **Target Static IP:** `192.168.1.180/24`
* **Subnet Mask:** `255.255.255.0` (`/24`)
* **Default Gateway:** `192.168.1.1`
* **DNS Servers:** `8.8.8.8`, `1.1.1.1`

---

## Step-by-Step Configuration

### 1. Identify the Netplan Configuration File

List the available configuration files inside the `/etc/netplan/` directory:

```bash
ls /etc/netplan/
```

*Example Output:*
```text
50-cloud-init.yaml
```

---

### 2. Create a Backup of the Original Configuration

Before modifying any configuration files, create a backup copy:

```bash
sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak
```

---

### 3. Edit the Netplan Configuration File

Open the Netplan configuration file in your preferred text editor:

```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```

Replace or modify the file contents with the following structure:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.1.180/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

> **Note on Syntax:** YAML formatting requires strict spacing. Use spaces for indentation—**do not use tabs**.

---

### 4. Apply the Configuration

Apply the new Netplan configuration:

```bash
sudo netplan apply
```

---

### 5. Verify the New IP Address

Verify that the static IP address has been assigned to interface `enp0s3`:

```bash
ip a show enp0s3
```

*Expected Output snippet:*
```text
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 ...
    inet 192.168.1.180/24 scope global enp0s3
```

---

## Rollback Procedure (If Needed)

If you need to restore the original configuration, run:

```bash
sudo cp /etc/netplan/50-cloud-init.yaml.bak /etc/netplan/50-cloud-init.yaml
sudo netplan apply
```
