# Unix Cheat Sheet
This repo is intended to collect a bunch of useful unix commands that can make Cloudera CDH deployment easier 

### User Management
 * Create a new user (as root user)
```
sudo su (become root)
adduser <username>
passwd <username>
```
* Add an existing user among the sudoers one (as root user)
```
cd /etc
visudo 
```
add the following line under the ROOT ALL=(ALL) ALL:
```
<username> ALL=(ALL) ALL
```
