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
mariadb << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;
CREATE USER IF NOT EXISTS '$MYSQL_DATABASE_USER'@'%' IDENTIFIED BY '$MYSQL_DATABASE_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_DATABASE_USER'@'%';
FLUSH PRIVILEGES;
SHUTDOWN;
EOF