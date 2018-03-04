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
