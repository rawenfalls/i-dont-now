#!/bin/sh

if [ -d "/run/mysqld" ]; then
	echo "run/mysqld is already exist"
	chown -R mysql:mysql /run/mysqld
else
	echo "run/mysqld is creating..."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi


if [ ! -d "/var/lib/mysql/mysql" ]; then

    echo "mysql_install_db initializes MySQL data directory and creates system tables..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null
    temp_file='temp_file'
    cat << EOF > $temp_file

USE mysql ;
FLUSH PRIVILEGES ;

DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

CREATE DATABASE $name_db CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$user_db'@'%' IDENTIFIED by '$password_db';
GRANT ALL PRIVILEGES ON $name_db.* TO '$user_db'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_maria_password_db';

FLUSH PRIVILEGES ;
EOF

	/usr/bin/mysqld --user=mysql --bootstrap < $temp_file
	echo "запись в демон файл окончена"
	rm -f $temp_file
	echo "mysql initialization process done."
    
fi

# remote connections is allow
 sed -i "s|.*skip-networking.*|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
 sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec /usr/bin/mysqld --user=mysql --console
