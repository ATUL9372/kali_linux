#!/bin/bash

## install all basic packages for ubuntu 

apt update && upgrade -y

apt install -y git iproute2 wget curl systemd nano net-tools htop tar gnupg gawk mawk grep sed make 

