# Ubuntu Time & Timezone Commands

## Check Current Date & Time

```bash
date
timedatectl
```

---

## Set Timezone (India)

```bash
sudo timedatectl set-timezone Asia/Kolkata
```

Verify:

```bash
timedatectl
```

---

## Disable Automatic Time Sync (Required Before Manual Time Change)

```bash
sudo timedatectl set-ntp false
```

---

## Set Date & Time Manually

**Syntax:**

```bash
sudo timedatectl set-time "YYYY-MM-DD HH:MM:SS"
```

**Example:**

```bash
sudo timedatectl set-time "2026-08-07 16:30:00"
```

---

## Set Only Date

```bash
sudo timedatectl set-time "2026-08-07"
```

---

## Set Only Time

```bash
sudo timedatectl set-time "16:30:00"
```

---

## Enable Automatic Time Sync

```bash
sudo timedatectl set-ntp true
```

---

## Verify Configuration

```bash
timedatectl
date
```


