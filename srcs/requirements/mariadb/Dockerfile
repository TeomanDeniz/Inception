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
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
RUN set -eux ; echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries
RUN apt -y update && apt -y upgrade
RUN apt -y install mariadb-server mariadb-client
RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
RUN chmod 777 /var/run/mysqld
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 644 /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY ./tools/init.sh /usr/local/bin/
RUN bash /usr/local/bin/init.sh
ENTRYPOINT  [ "mysqld_safe" ]
