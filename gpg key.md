# Create GPG Key

* [GPG Cheat sheet](http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/) -
Quick'n easy gpg cheatsheet 

* [GnuPG](https://devhints.io/gnupg) -

GnuPG is a complete and free implementation of the OpenPGP standard.

### Install gpg for debian

      sudo apt-get install gnupg

### Create gpg key

      gpg --full-gen-key
      
### List of all created gpg keys

      gpg --list-keys
      
### Export a public key into file public.key
  
      gpg --export -a "User Name" > public.key

### Import your public key 

      gpg --import public.key

### Import target public key 

Enter target public keys type the below commad and copy key number

      gpg --import Enter-target-public-key.key
    
### Encrypt your txt file for local file

      gpg -r < enter your (target) id name >  -e <file name>
      
### Encrypt the file for other users

Encryption time Enter target (other users) imported public key file and enter key numbers for target (other users)

      gpg -e Enter-file-name 
      
### Decrypt file 

      gpg -d Enter-file-name.gpg
      
 
    
      
