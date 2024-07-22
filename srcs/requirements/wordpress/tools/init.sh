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

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
mkdir -p /var/www/html/
mv wordpress/* /var/www/html/
rm -rf latest.tar.gz
chown -R www-data:www-data /var/www/html/
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	-O /usr/local/bin/wp
chmod +x /usr/local/bin/wp
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html/
wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html/
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html/
wp config set DB_HOST mariadb --allow-root --path=/var/www/html/
################################ [v] BONUS [v] #################################
wp config set WP_REDIS_PORT 6379 --add --type=constant --allow-root \
	--path=/var/www/html/
wp config set WP_REDIS_HOST redis --add --type=constant --allow-root \
	--path=/var/www/html/
wp config set WP_CACHE true --add --type=constant --allow-root \
	--path=/var/www/html/
################################ [^] BONUS [^] #################################