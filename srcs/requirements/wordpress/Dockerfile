# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/22 12:48:13 by hdeniz            #+#    #+#              #
#    Updated: 2024/07/22 12:51:01 by hdeniz           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD
ARG EMAIL
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV EMAIL=${EMAIL}
RUN set -eux ; echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries
RUN apt -y update && apt -y upgrade
RUN apt -y install wget php7.4-fpm php7.4-mysql mariadb-client
################################ [v] BONUS [v] #################################
RUN apt -y install php7.4-redis redis-tools
################################ [^] BONUS [^] #################################
RUN mv /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.default
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
RUN ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm
RUN mkdir -p /run/php
RUN chmod 755 /run/php
COPY ./tools/init.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/init.sh
RUN bash /usr/local/bin/init.sh
RUN mkdir -p /var/www/html/wp-content/uploads/2024/02/
COPY ./conf/uploads/* /var/www/html/wp-content/uploads/2024/02/
RUN chmod -R 755 /var/www/html/wp-content/uploads/
RUN chmod 644 /var/www/html/wp-content/uploads/2024/02/*
RUN chown -R www-data:www-data /var/www/html/wp-content/uploads/
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT  [ "bash", "/usr/local/bin/entrypoint.sh" ]
