 ## User Management
 
 * Create a new user (as root user)
```
[root]$ adduser <username>
[root]$ passwd <username>
```
* Add an existing user among the sudoers one (as root user) by editing the /etc/sudoers file
```
[root]$ cd /etc
[root]$ visudo 
```
add the following line under the ROOT ALL=(ALL) PASSWD:ALL
```
<username> ALL=(ALL) ALL
```
* Try to check if you can launch sudo commands (with the new username)
```
[root]$ su <username>
[<username>]$ sudo su 
We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for <username>: 
```
* Run sudo commands without password 
```
[root]$ cd /etc
[root]$ visudo 
```
add the following line under the ROOT ALL=(ALL) NOPASSWD:ALL
```
<username> ALL=(ALL) NOPASSWD:ALL
```
* In order to allow a user to connect via ssh (via username and password), as root you have to edit file under /etc/ssh/sshd_config
```
[root]$ sudo vi /etc/ssh/sshd_config
+ PasswordAuthentication yes
+ Allowusers <username> 
[root]$ service sshd restart
```
