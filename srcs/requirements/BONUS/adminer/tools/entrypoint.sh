#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/22 12:48:13 by hdeniz            #+#    #+#              #
#    Updated: 2024/07/22 12:51:01 by hdeniz           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

while ! test -f /var/www/html/wp-config.php; do
	echo "Waiting for Wordpress to be ready..."
	sleep 1
done
mkdir -p /var/run/php
sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|g" \
	/etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /var/www/html
wget --no-check-certificate "http://www.adminer.org/latest.php" \
	-O /var/www/html/adminer.php
chown www-data:www-data /var/www/html/adminer.php
chmod 755 /var/www/html/adminer.php
exec "$@"