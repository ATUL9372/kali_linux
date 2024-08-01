# Install SSH

### install openssh in server

      sudo apt-get install openssh-server openssh-client
      
###  create public and private key 

      ssh-keygen -t rsa -b 4096 -C "Atul Y"

### check ssh status

      sudo systemctl status sshd.service


### ssh config file 

      Host my-website.com
          HostName 192.168.11.11
          User my-user
          IdentityFile ~/.ssh/id_rsa

### connect remote server usig ssh config file commands

      ssh my-website.com

