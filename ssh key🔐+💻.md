# Install SSH

### install openssh in server

      sudo apt-get install -y openssh-server openssh-client

### install openssh in client
      sudo apt-get install -y openssh-client
      
###  create public and private key 

      ssh-keygen -t rsa -b 4096 -C "Atul Y"

### check ssh status

      sudo systemctl status sshd.service

### ssh-copy-id send your ssh Public key 🔑 on remote server

      ssh-copy-id -i xyz.pub <Username>@<remote-server-ip>
      
### create ssh config file : .ssh/config  

      Host my-website.com
          HostName 192.168.11.11
          User my-user
          IdentityFile ~/.ssh/id_rsa

### connect remote server usig ssh config file commands

      ssh my-website.com



