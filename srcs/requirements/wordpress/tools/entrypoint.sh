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

while ! wp db check --allow-root --path=/var/www/html/; do
	echo "Waiting for Database to be ready..."
	sleep 1
done
wp core download --path="/var/www/html/wordpress" --allow-root
wp config create    --dbname="$MYSQL_DATABASE" \
                    --dbuser="$MYSQL_USER" \
                    --dbpass="$MYSQL_PASSWORD" \
                    --dbhost="mariadb" \
                    --allow-root
wp core install     --url="$DOMAIN_NAME" \
                    --title="Inception project" \
                    --admin_user="superuser_wp" \
                    --admin_password="$MYSQL_ROOT_PASSWORD" \
                    --admin_email="$EMAIL" \
                    --allow-root
wp user create      "$MYSQL_USER" \
                    "$EMAIL" \
                    --role=author \
                    --user_pass="$MYSQL_ROOT_PASSWORD" \
                    --allow-root
wp plugin install redis-cache --activate --allow-root --path=/var/www/html/
wp redis enable --allow-root --path=/var/www/html/
php-fpm7.4 -F