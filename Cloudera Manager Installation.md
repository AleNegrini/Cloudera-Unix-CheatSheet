## Cloudera Manager installation

#### Java OpenJDK 
On the host on which you would like to install the CM, you should install the Java OpenJDK:
```
sudo yum install java-1.7.0-openjdk
```

#### Install Web server
```
sudo service httpd
sudo service httpd start
```

#### Cloudera Manager installation (Path B)
Download the repo file. Click the link for your RHEL or CentOS system in the table, find the appropriate repo file, and save in /etc/yum.repos.d/. For example create cloudera-manager.repo file with the following content:
```
[cloudera-cdh5]
# Packages for Cloudera's Distribution for Hadoop, Version 5, on RedHat or CentOS 5 x86_64
name=Cloudera's Distribution for Hadoop, Version 5
baseurl=https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/5/
gpgkey =https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/RPM-GPG-KEY-cloudera 
gpgcheck = 1
```

Install yum-utils and createrepo
```
sudo yum install yum-utils
sudo yum install createrepo
```

On the same computer as in the previous steps, download the yum repository into a temporary location. On RHEL/CentOS 6, you can use a command such as:
```
reposync -r cloudera-cdh5
createrepo
```

Change the cloudera-manager.repo file 

Then install Cloudera Manager
```
sudo yum install cloudera-manager-server
sudo yum install cloudera-manager-daemons
```

__Important__
```
/usr/share/cmf/schema/scm_prepare_database.sh database-type [options] database-name username password
```

Finally run it 
```
sudo service cloudera-scm-server start
```


