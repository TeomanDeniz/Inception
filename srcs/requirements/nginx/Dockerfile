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
ARG DOMAIN_NAME
ARG CERTS_KEY
ARG CERTS_CRT
RUN set -eux ; echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries
RUN apt -y update && apt -y upgrade
RUN apt -y install nginx openssl 
RUN openssl req -x509 -sha256 -nodes \
	-newkey rsa:4096 \
	-days 365 \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42SP/OU=Inception/CN=hdeniz.42.fr" \
	-keyout ${CERTS_KEY} \
	-out ${CERTS_CRT} 
RUN sed -i 's/ssl_protocols.*/ssl_protocols TLSv1.3;/' /etc/nginx/nginx.conf
COPY ./conf/https.conf /etc/nginx/conf.d/
RUN sed -i "s|INSERT_DOMAIN_NAME_HERE|${DOMAIN_NAME}|g" \
	/etc/nginx/conf.d/https.conf
RUN sed -i "s|INSERT_KEY_PATH_HERE|${CERTS_KEY}|g" /etc/nginx/conf.d/https.conf
RUN sed -i "s|INSERT_CRT_PATH_HERE|${CERTS_CRT}|g" /etc/nginx/conf.d/https.conf
COPY ./conf/http.conf /etc/nginx/conf.d/
RUN sed -i "s|INSERT_DOMAIN_NAME_HERE|${DOMAIN_NAME}|g" \
	/etc/nginx/conf.d/https.conf
ENTRYPOINT	[ "nginx", "-g", "daemon off;" ]
