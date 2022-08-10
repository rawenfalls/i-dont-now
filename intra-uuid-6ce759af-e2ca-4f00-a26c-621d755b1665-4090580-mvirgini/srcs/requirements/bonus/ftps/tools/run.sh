#!/bin/sh

# Create a new user for FTP server
adduser -D ${ftp_user_name} && echo ${ftp_user_name}:${ftp_user_pwd} | chpasswd

# Change owner to home directory
chown -R ${ftp_user_name}:${ftp_user_name} /home/"${ftp_user_name}"

echo "ftps is running..."

# Running Command : "/usr/sbin/vsftpd" make the service run in the foreground
 /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
