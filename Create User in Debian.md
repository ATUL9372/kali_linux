# Create User in Debian

### create user with home folder

sudo adduser username


### add username in sudo group

sudo usermod -aG sudo username

### login new username 

su username

### delete user

sudo deluser username

### visudo file

allow member of Groups SUDO  to execute

%username ALL=(ALL:ALL) NOPASSWD:ALL       # no password ask

%username ALL=(ALL:ALL) PASSWD:ALL			# every time password ask 
