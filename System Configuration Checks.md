## System Configuration Checks
In a professional services engagement, Cloudera walks a customer through a questionnaire and supplies a guide to verify hardware, networking, OS configuration, disk mounts, and other properties.
Using the steps below, verify the settings of your instances.

#### Check vm.swappiness on all your nodes
```
cat /proc/sys/vm/swappiness
30
```
This is not suitable for Hadoop cluster nodes, because it can cause processes to get swapped out even when there is free memory available. This can affect stability and performance, and may cause problems such as lengthy garbage collection pauses for important system daemons. Cloudera recommends that you set this parameter to 10 or less.

First temporarly change its value
```
sudo sysctl vm.swappiness=1
```
And then add this line in order to change it permanently
```
sudo vi /etc/sysctl.conf
+ vm.swappiness = 1
```
[Set swappiness script](https://github.com/AleNegrini/Cloudera-Unix-CheatSheet/blob/master/scripts/set_swappiness_to_one.sh)

#### Check the mount attributes of all volumes (*)
```
cat /etc/fstab

#
# /etc/fstab
# Created by anaconda on Tue Jan 30 02:14:21 2018
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
UUID=9df472f4-1b0f-41c0-a6eb-89574d2caee3 /                       xfs     defaults        0 0
```
```
df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        60G  1.5G   59G   3% /
devtmpfs        3.6G     0  3.6G   0% /dev
tmpfs           3.6G     0  3.6G   0% /dev/shm
tmpfs           3.6G  8.3M  3.6G   1% /run
tmpfs           3.6G     0  3.6G   0% /sys/fs/cgroup
tmpfs           732M     0  732M   0% /run/user/1001
```
#### Check that transparent hugepages are disabled
```
cat /sys/kernel/mm/transparent_hugepage/defrag
always madvise [never]
```
If not disabled type the following command (this will not survive to a reboot)
```
echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
```
If you want to make it permanent add this line to __/etc/rc.local__ file
```
+ echo "never" > /sys/kernel/mm/transparent_hugepage/defrag
```
#### Get info about network interfaces
```
netstat -i
Kernel Interface table
Iface      MTU    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
eth0      1460    50252      0      0 0         48307      0      0      0 BMRU
lo       65536        0      0      0 0             0      0      0      0 LRU
```
```
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP qlen 1000
    link/ether 42:01:0a:80:00:02 brd ff:ff:ff:ff:ff:ff
    inet 10.128.0.2/32 brd 10.128.0.2 scope global dynamic eth0
       valid_lft 65130sec preferred_lft 65130sec
    inet6 fe80::4001:aff:fe80:2/64 scope link
       valid_lft forever preferred_lft forever
```
#### Set /etc/hosts file
```
sudo vi /etc/hosts
+ <ip_address> <fqdn> <shortname>
```
#### Show that forward and reverse lookups are working (for each host) 
```
getent ahosts lion
10.128.0.2      STREAM lion.c.cloudera-trial.internal
10.128.0.2      DGRAM
10.128.0.2      RAW
```
```
getent ahosts 10.128.0.2
10.128.0.2      STREAM 10.128.0.2
10.128.0.2      DGRAM
10.128.0.2      RAW
```
#### Show that forward and reverse lookups are working (for each host) 
```
nslookup lion
Server:         169.254.169.254
Address:        169.254.169.254#53

Non-authoritative answer:
Name:   lion.c.cloudera-trial.internal
Address: 10.128.0.2
```
```
nslookup 10.128.0.2
Server:         169.254.169.254
Address:        169.254.169.254#53

Non-authoritative answer:
2.0.128.10.in-addr.arpa name = lion.c.cloudera-trial.internal.
```
#### Install and run nscd
```
yum install nscd
service nscd start
chkconfig nscd on
nscd -g
```
Test if it is running
```
service nscd status
Redirecting to /bin/systemctl status nscd.service
● nscd.service - Name Service Cache Daemon
   Loaded: loaded (/usr/lib/systemd/system/nscd.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2018-03-04 10:08:37 UTC; 2min 55s ago
 Main PID: 13595 (nscd)
   CGroup: /system.slice/nscd.service
           └─13595 /usr/sbin/nscd
```
#### Install and run ntpd

```
yum install ntp
service ntpd start
chkconfig ntpd on
```
Test if it is running
```
service ntpd status
Redirecting to /bin/systemctl status ntpd.service
● ntpd.service - Network Time Service
   Loaded: loaded (/usr/lib/systemd/system/ntpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2018-03-04 10:21:32 UTC; 47s ago
  Process: 11721 ExecStart=/usr/sbin/ntpd -u ntp:ntp $OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 11722 (ntpd)
   CGroup: /system.slice/ntpd.service
           └─11722 /usr/sbin/ntpd -u ntp:ntp -g
```
Synchronize the node
```
ntpdate -u <your_ntp_server>
```
Synchronize the system clock (to prevent synchronization problems)
```
hwclock --systohc
```
