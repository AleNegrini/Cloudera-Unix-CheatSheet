## Networking
When configuring Hadoop, you will be required to identify various nodes in Hadoop’s configuration files. Use hostnames, not IP addresses, to identify nodes when configuring Hadoop.

* Get hostname (short name)
```
[root]$ hostname
```
* Get hostname (fully qualified domain name)
```
[root]$ hostname --fqdn
```
* Edit the hosts files
```
[root]$ sudo vi /etc/hosts
+ <ip_address> <fully_qualified_domain_name> <shortname>
(es. 10.0.3.4 lion.google.com lion)
```

DNS is preferred for hostname resolution (rather than /etc/hosts)
