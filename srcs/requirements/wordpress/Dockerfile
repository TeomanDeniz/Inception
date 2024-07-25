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
ARG EMAIL
ARG DOMAIN_NAME
ARG WP_ADMIN_NAME
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV EMAIL=${EMAIL}
ENV DOMAIN_NAME=${DOMAIN_NAME}
ENV WP_ADMIN_NAME=${WP_ADMIN_NAME}
RUN set -eux ; echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y php-fpm php-mysql sendmail wget
################################ [v] BONUS [v] #################################
RUN apt -y install php7.4-redis redis-tools
################################ [^] BONUS [^] #################################
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp-cli
RUN mkdir -p /var/www/html
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
RUN mkdir -p /var/www/html/wp-content/uploads/2024/02/
COPY ./conf/uploads/* /var/www/html/wp-content/uploads/2024/02/
RUN chmod -R 755 /var/www/html/wp-content/uploads/
RUN chmod 644 /var/www/html/wp-content/uploads/2024/02/*
RUN chown -R www-data:www-data /var/www/html/wp-content/uploads/
COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh
WORKDIR /var/www/html
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/php-fpm7.4", "--nodaemonize" ]