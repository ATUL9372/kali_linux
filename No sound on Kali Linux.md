# No sound in kali linux

Follow the steps

# Step 1

kali@kali:~$ apt list --installed | grep pipewire-pulse

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

pipewire-pulse/kali-rolling,now 0.3.51-1 amd64 [installed,automatic]
kali@kali:~$

# Step 2

kali@kali:~$ sudo apt purge --autoremove pipewire-pulse

# Step 3

kali@kali:~$ sudo reboot
