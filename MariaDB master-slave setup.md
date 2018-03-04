## MariaDB/MySql Setup and configuration

#### Setup Mysql Server (Master and Slave)

Install MariaDB Server on master and slave cluster host and start it 
```
sudo yum install mariadb-server
sudo service mariadb start
```
Ensure the MariaDB server starts at boot:
```
sudo systemctl enable mariadb
```

#### Secure Mysql Server
Run it on both master and slave servers
```
sudo /usr/bin/mysql_secure_installation
[...]
Enter current password for root (enter for none):
OK, successfully used password, moving on...
[...]
Set root password? [Y/n] y
New password:
Re-enter new password:
[...]
Remove anonymous users? [Y/n] y
[...]
Disallow root login remotely? [Y/n] n
[...]
Remove test database and access to it [Y/n] y
[...]
Reload privilege tables now? [Y/n] y
 ... Success!
```

#### Master server configuration
```
mysql -u <username> -p
```
```
GRANT REPLICATION SLAVE ON *.* TO 'user'@'FQDN' IDENTIFIED BY 'password';
SET GLOBAL binlog_format = 'ROW'; 
FLUSH TABLES WITH READ LOCK;
```
```
SHOW MASTER STATUS;
UNLOCK TABLES;
```
```
MariaDB [(none)]> SHOW MASTER STATUS;
+--------------------+----------+--------------+------------------+
| File               | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+--------------------+----------+--------------+------------------+
| master1-bin.000001 |      422 |              |                  |
+--------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
```
#### Slave server configuration
```
CHANGE MASTER TO MASTER_HOST='lion.c.cloudera-trial.internal', MASTER_USER='root',MASTER_PASSWORD='123qwe..',MASTER_PORT=3306,MASTER_LOG_FILE='master1-bin.000002',MASTER_LOG_POS=599,MASTER_CONNECT_RETRY=10;
```
```
START SLAVE;
```
```
SHOW SLAVE STATUS \G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: lion.c.cloudera-trial.internal
                  Master_User: root
                  Master_Port: 3306
                Connect_Retry: 10
              Master_Log_File: master1-bin.000002
          Read_Master_Log_Pos: 599
               Relay_Log_File: slave1-relay-bin.000002
                Relay_Log_Pos: 531
        Relay_Master_Log_File: master1-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table:
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 599
              Relay_Log_Space: 826
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 10
1 row in set (0.00 sec)
```

#### Install MySql JDBC driver on all the hosts
```
cd /tmp/
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz
tar -zxvf mysql-connector-java-5.1.40.tar.gz
sudo mkdir -p /usr/share/java/
sudo mv mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
```
[Script MySql JDBC driver download](https://github.com/AleNegrini/Cloudera-Unix-CheatSheet/blob/master/scripts/download_install_jdbc.sh)

#### Database creation
```
MariaDB [(none)]> create database amon DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> create database rman DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> create database metastore DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> create database sentry DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> create database nav DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> create database navms DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> grant all on amon.* to 'amon' IDENTIFIED BY 'amon_password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all on rman.* to 'rman' IDENTIFIED BY 'rman_password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all on metastore.* to 'hive' IDENTIFIED BY 'hive_password';      Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all on sentry.* to 'sentry' IDENTIFIED BY 'sentry_password';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all on nav.* to 'nav' IDENTIFIED BY 'nav_password';     Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> grant all on navms.* to 'navms' IDENTIFIED BY 'navms_password';
Query OK, 0 rows affected (0.00 sec)

```
Check in the replica server you can see these databases; 
