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

chown -R www-data: /var/www/*
chmod -R 755 /var/www/*
mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid
chown -R www-data:www-data /var/www/html/

if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Wordpress is preparing..."

	while ! wp-cli core download --allow-root ; do
		echo "Download failed, retrying again..."
	done

	wp-cli config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb

	wp-cli core install --allow-root \
		--url=$DOMAIN_NAME \
		--title="wordpress" \
		--admin_user=$WP_ADMIN_NAME \
		--admin_password=$MYSQL_PASSWORD \
		--admin_email=$EMAIL

	wp-cli user create --allow-root \
		$MYSQL_USER "asd@asd.com" \
		--user_pass=$MYSQL_PASSWORD
fi
wp-cli config set WP_REDIS_PORT 6379 --add --type=constant --allow-root --path=/var/www/html/
wp-cli config set WP_REDIS_HOST redis --add --type=constant --allow-root --path=/var/www/html/
wp-cli config set WP_CACHE true --add --type=constant --allow-root --path=/var/www/html/
echo "Website is ready to use!"
exec "$@"