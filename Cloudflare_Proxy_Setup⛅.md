# Restrict Web Traffic to Cloudflare IPs Only (UFW on Ubuntu)

Lock down ports **80** and **443** on an Ubuntu server so that only Cloudflare's proxy IPs can reach your origin. SSH (port 22) stays open so you don't get locked out.

> Official IP list: https://www.cloudflare.com/ips/
> IPv4: https://www.cloudflare.com/ips-v4 | IPv6: https://www.cloudflare.com/ips-v6

---

## Why?

When your domain is proxied through Cloudflare (orange cloud), all legitimate web traffic comes from Cloudflare's IP ranges. If your origin also accepts traffic from anywhere, attackers can bypass Cloudflare (WAF, DDoS protection, rate limits) by hitting your server IP directly. Allowing only Cloudflare IPs on 80/443 closes that gap.

---

## Prerequisites

- Ubuntu server with `sudo` access
- Domain proxied through Cloudflare
- Console or alternate access to the server (in case of a firewall mistake)

---

## 1. Install UFW and allow SSH first

> **Important:** allow SSH **before** enabling UFW, otherwise you can lock yourself out.

```bash
sudo apt update
sudo apt install ufw -y

# Allow SSH (22/tcp is enough; plain `allow 22` also opens UDP)
sudo ufw allow 22/tcp
sudo ufw allow 22

# Enable the firewall
sudo ufw enable

# Check status
sudo ufw status
```

---

## 2. Remove any open 80/443 rules (if present)

```bash
sudo ufw status numbered

sudo ufw delete allow 80/tcp
sudo ufw delete allow 443/tcp
```

---

## 3. Allow Cloudflare IPv4 ranges

### Option A: Manual commands

```bash
sudo ufw allow from 103.21.244.0/22 to any port 80 proto tcp
sudo ufw allow from 103.21.244.0/22 to any port 443 proto tcp

sudo ufw allow from 103.22.200.0/22 to any port 80 proto tcp
sudo ufw allow from 103.22.200.0/22 to any port 443 proto tcp

sudo ufw allow from 103.31.4.0/22 to any port 80 proto tcp
sudo ufw allow from 103.31.4.0/22 to any port 443 proto tcp

sudo ufw allow from 104.16.0.0/13 to any port 80 proto tcp
sudo ufw allow from 104.16.0.0/13 to any port 443 proto tcp

sudo ufw allow from 104.24.0.0/14 to any port 80 proto tcp
sudo ufw allow from 104.24.0.0/14 to any port 443 proto tcp

sudo ufw allow from 108.162.192.0/18 to any port 80 proto tcp
sudo ufw allow from 108.162.192.0/18 to any port 443 proto tcp

sudo ufw allow from 131.0.72.0/22 to any port 80 proto tcp
sudo ufw allow from 131.0.72.0/22 to any port 443 proto tcp

sudo ufw allow from 141.101.64.0/18 to any port 80 proto tcp
sudo ufw allow from 141.101.64.0/18 to any port 443 proto tcp

sudo ufw allow from 162.158.0.0/15 to any port 80 proto tcp
sudo ufw allow from 162.158.0.0/15 to any port 443 proto tcp

sudo ufw allow from 172.64.0.0/13 to any port 80 proto tcp
sudo ufw allow from 172.64.0.0/13 to any port 443 proto tcp

sudo ufw allow from 173.245.48.0/20 to any port 80 proto tcp
sudo ufw allow from 173.245.48.0/20 to any port 443 proto tcp

sudo ufw allow from 188.114.96.0/20 to any port 80 proto tcp
sudo ufw allow from 188.114.96.0/20 to any port 443 proto tcp

sudo ufw allow from 190.93.240.0/20 to any port 80 proto tcp
sudo ufw allow from 190.93.240.0/20 to any port 443 proto tcp

sudo ufw allow from 197.234.240.0/22 to any port 80 proto tcp
sudo ufw allow from 197.234.240.0/22 to any port 443 proto tcp

sudo ufw allow from 198.41.128.0/17 to any port 80 proto tcp
sudo ufw allow from 198.41.128.0/17 to any port 443 proto tcp
```

### Option B: One-shot script (always uses the latest list)

Save as `cloudflare-ufw.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

# Fetch the current Cloudflare IP ranges (IPv4 + IPv6)
for ip in $(curl -fsS https://www.cloudflare.com/ips-v4; echo; curl -fsS https://www.cloudflare.com/ips-v6); do
  [ -z "$ip" ] && continue
  ufw allow from "$ip" to any port 80  proto tcp comment 'Cloudflare'
  ufw allow from "$ip" to any port 443 proto tcp comment 'Cloudflare'
done

ufw reload
```

Run it:

```bash
chmod +x cloudflare-ufw.sh
sudo ./cloudflare-ufw.sh
```

---

## 4. (Optional) Allow Cloudflare IPv6 ranges

Only needed if your server has IPv6 enabled and Cloudflare connects to it over IPv6. Verify the current list at https://www.cloudflare.com/ips-v6.

```bash
for ip in 2400:cb00::/32 2606:4700::/32 2803:f800::/32 2405:b500::/32 2405:8100::/32 2a06:98c0::/29 2c0f:f248::/32; do
  sudo ufw allow from $ip to any port 80  proto tcp
  sudo ufw allow from $ip to any port 443 proto tcp
done
```

---

## 5. Verify

```bash
sudo ufw status numbered
```

Expected output (abridged):

```
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 22/tcp                     ALLOW IN    Anywhere
[ 2] 80/tcp                     ALLOW IN    103.21.244.0/22
[ 3] 443/tcp                    ALLOW IN    103.21.244.0/22
[ 4] 80/tcp                     ALLOW IN    103.22.200.0/22
[ 5] 443/tcp                    ALLOW IN    103.22.200.0/22
...
[31] 80/tcp                     ALLOW IN    198.41.128.0/17
[32] 443/tcp                    ALLOW IN    198.41.128.0/17
[33] 22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

### Test it

```bash
# Through Cloudflare: should work
curl -I https://yourdomain.com

# Directly to origin IP: should time out / be blocked
curl -I --max-time 10 http://YOUR_SERVER_IP
```

---

## Useful commands

| Task | Command |
|------|---------|
| Show rules with numbers | `sudo ufw status numbered` |
| Delete a rule by number | `sudo ufw delete <number>` |
| Reload firewall | `sudo ufw reload` |
| Disable firewall | `sudo ufw disable` |
| Reset all rules | `sudo ufw reset` |
| Set default policies | `sudo ufw default deny incoming && sudo ufw default allow outgoing` |

> Tip: when deleting by number, delete from the **highest number first**, since numbers shift after each deletion.

---

## Notes and best practices

- **Keep the list updated.** Cloudflare occasionally changes its ranges. Re-run the script (or re-check https://www.cloudflare.com/ips/) periodically, e.g. via cron.
- **Restrict SSH if you can.** Instead of `allow 22/tcp` from anywhere, limit it to your own IP: `sudo ufw allow from YOUR_IP to any port 22 proto tcp`. Consider also `sudo ufw limit 22/tcp` to rate-limit brute force attempts.
- **Docker caveat.** Docker publishes ports by editing iptables directly and can bypass UFW rules. If you run containers with `-p 80:80`, use the `DOCKER-USER` chain or bind to localhost behind a reverse proxy.
- **Real visitor IPs.** Behind Cloudflare, your web server sees Cloudflare's IPs. Use the `CF-Connecting-IP` header (or Nginx `real_ip` module / Apache `mod_remoteip`) to log real client IPs.
- **Cloudflare SSL mode.** Use *Full (strict)* with an origin certificate for end-to-end encryption.
- **Other ports.** Anything else you expose (databases, custom apps) needs its own explicit rule. UFW denies all other incoming traffic by default.

---

## References

- Cloudflare IP ranges: https://www.cloudflare.com/ips/
- UFW docs: https://help.ubuntu.com/community/UFW
