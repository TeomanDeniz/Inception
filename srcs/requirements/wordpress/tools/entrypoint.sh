#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/22 12:48:13 by hdeniz            #+#    #+#              #
#    Updated: 2024/07/23 06:52:01 by hdeniz           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

while ! wp db check --allow-root --path=/var/www/html/; do
	echo "Waiting for Database to be ready..."
	sleep 1
done
test -d /var/www/html/wordpress || wp core download --path="/var/www/html/wordpress" --allow-root
test -f /var/www/html/wordpress/wp-config.php && rm /var/www/html/wordpress/wp-config.php
wp config create    --dbname="$MYSQL_DATABASE" \
                    --dbuser="$MYSQL_USER" \
                    --dbpass="$MYSQL_ROOT_PASSWORD" \
                    --dbhost="mariadb" \
                    --allow-root
wp core install     --url="$DOMAIN_NAME" \
                    --title="Inception project" \
                    --admin_user="superuser_wp" \
                    --admin_password="$MYSQL_ROOT_PASSWORD" \
                    --admin_email="$EMAIL" \
                    --allow-root --path="/var/www/html/wordpress"
wp user create      "$MYSQL_USER" \
                    "random@email.com" \
                    --role=author \
                    --user_pass="$MYSQL_ROOT_PASSWORD" \
                    --allow-root
wp plugin install redis-cache --activate --allow-root --path=/var/www/html/
wp redis enable --allow-root --path=/var/www/html/
php-fpm7.4 -F --nodaemonize