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

service mariadb start
while ! mariadb -u root -e "SELECT 1" >/dev/null 2>&1; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
done
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" || exit 1
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" || exit 1
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" || exit 1
mysql -u root -e "FLUSH PRIVILEGES;" || exit 1
