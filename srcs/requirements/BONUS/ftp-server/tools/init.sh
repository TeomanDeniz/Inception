#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/22 12:48:13 by hdeniz            #+#    #+#              #
#    Updated: 2024/07/22 12:51:01 by hdeniz           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
	echo "FTP_USER and FTP_PASSWORD must be set"
	exit 1
fi
if [ ! -f /usr/local/bin/vsftpd.conf.bak ]; then
	mkdir -p /var/run/vsftpd/empty
	adduser --disabled-password $FTP_USER --gecos ""
	mkdir -p /home/$FTP_USER/ftp
	echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
	chown -R $FTP_USER:$FTP_USER /home/$FTP_USER
	chmod 755 /home/$FTP_USER/ftp
	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist
	cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
	mv /usr/local/bin/vsftpd.conf /etc/vsftpd.conf
	sed -i "s/^local_root=.*/local_root=\/home\/$FTP_USER\/ftp/" \
		/etc/vsftpd.conf
	chmod 644 /etc/vsftpd.conf
	unset FTP_USER
	unset FTP_PASSWORD
fi
vsftpd /etc/vsftpd.conf