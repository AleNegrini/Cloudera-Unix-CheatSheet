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
