# Install SSH

### install openssh in server

      sudo apt-get install openssh-server openssh-client
      
###  create public and private key 

      ssh-keygen -t rsa -b 4096 -C "Atul Y"

### check ssh status

      sudo systemctl status sshd.service


