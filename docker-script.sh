#!/bin/bash

## install all basic packages for ubuntu 

apt update && upgrade -y

apt install -y git iproute2 wget curl systemd nano net-tools htop tar gnupg gawk mawk grep sed make  openssh-server  sudo 

apt install system-config-printer system-config-printer-common system-config-printer-udev system-tools-backends systemd systemd-sysv systemd-timesyncd -y



# openssh-client
