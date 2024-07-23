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
wp plugin install redis-cache --activate --allow-root --path=/var/www/html/
wp redis enable --allow-root --path=/var/www/html/
php-fpm7.4 -F