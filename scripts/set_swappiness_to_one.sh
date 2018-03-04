#!/bin/bash
sudo sysctl vm.swappiness=1
echo "vm.swappiness=1" >> /etc/sysctl.conf 
