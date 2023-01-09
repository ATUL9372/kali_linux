# Network Interface Restart

* [linux-restart-network-interface](https://www.cyberciti.biz/faq/linux-restart-network-interface/) -
How do I restart the network interface under Linux operating systems after making changes to IP configuration without rebooting the server?

### UP Network Interface

      sudo ip link set [Interface_ name] up
      
### dhclient reload for showing ip's

      sudo dhclient 
    
### Down Network Interface


      sudo ip link set [Interface_ name] down

