cd /tmp/
wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz
tar -zxvf mysql-connector-java-5.1.40.tar.gz
sudo mkdir -p /usr/share/java/
sudo mv mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar /usr/share/java/mysql-connector-java.jar
