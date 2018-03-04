#### System Configuration Checks
In a professional services engagement, Cloudera walks a customer through a questionnaire and supplies a guide to verify hardware, networking, OS configuration, disk mounts, and other properties.
Using the steps below, verify the settings of your instances.

* Check vm.swappiness on all your nodes
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
