## OS Configuration

* The traditional recommendation for worker nodes was to set swappiness (vm.swappiness) to 0. However, this behavior changed in newer kernels and we now recommend setting this to 1.
Check the actual swappiness value
```
[root]$ cat /proc/sys/vm/swappiness
```
Set the swappiness value (two alternative options)
```
[root]$ sysctl vm.swappiness=1
[root]$ echo "vm.swappiness = 1" >> /etc/sysctl.conf
```
* Disable SELinux
```
[root]$ cat /etc/sysconfig/selinux
- SELINUX=enforcing
+ SELINUX=disabled
```
Reboot in order to apply changes
```
[root]$ reboot
```
* User Limits
The default file handle limits (aka ulimits) of 1024 for most distributions are likely not set high enough. 
```
[root]$ ulimit -a
[root]$ ulimit <parameter> <value>
```
* Transparent Huge Page (THP)
Most Linux platforms supported by CDH 5 include a feature called Transparent Huge Page compaction, which interacts poorly with Hadoop workloads and can seriously degrade performance. 
Disable Transparent Huge Page compaction since it can degrade the performance of Hadoop workloads
```
[root]$ cat /sys/kernel/mm/transparent_hugepage/defrag
[root]$ echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag
```
