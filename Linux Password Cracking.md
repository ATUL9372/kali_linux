# Linux Password Cracking

### Install John

        sudo apt install john

#
        sudo cat /etc/passwd > password.txt
#
        sudo cat /etc/shadow > shadow.txt
#
        unshadow password.txt shadow.txt > final-password.txt

### Create Password WordList

#
    nano password-list.txt
#
    john --wordlist=/tmp/password-list.txt final-password.txt 
#
    john --show final-password.txt 

### Done !
