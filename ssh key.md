# Install SSH

### install openssh in server

      sudo apt-get install openssh-server openssh-client
      
###  create public and private key 

      ssh-keygen -t rsa -b 4096 -C "Atul Y"

### check ssh status

      sudo systemctl status sshd.service


### ssh config file 

      Host my-website.com
          HostName my-website.com
          User my-user
          IdentityFile ~/.ssh/id_rsa


