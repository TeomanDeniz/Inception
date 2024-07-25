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
RUN set -eux ; echo 'Acquire::Retries "5";' > /etc/apt/apt.conf.d/80-retries
ARG DOMAIN_NAME
ARG CERTS_KEY
ARG CERTS_CRT
RUN apt -y update && apt -y upgrade
RUN apt -y install nginx openssl 
RUN openssl req -x509 -sha256 -nodes \
	-newkey rsa:4096 \
	-days 365 \
	-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42SP/OU=Inception/CN=${DOMAIN_NAME}" \
	-keyout ${CERTS_KEY} \
	-out ${CERTS_CRT} 
RUN sed -i 's/ssl_protocols.*/ssl_protocols TLSv1.3;/' /etc/nginx/nginx.conf
COPY ./conf/https.conf /etc/nginx/conf.d/
RUN sed -i "s|!DOMAIN_NAME!|${DOMAIN_NAME}|g" \
	/etc/nginx/conf.d/https.conf
RUN sed -i "s|!KEY_PATH!|${CERTS_KEY}|g" /etc/nginx/conf.d/https.conf
RUN sed -i "s|!CRT_PATH!|${CERTS_CRT}|g" /etc/nginx/conf.d/https.conf
COPY ./conf/http.conf /etc/nginx/conf.d/
RUN sed -i "s|!DOMAIN_NAME!|${DOMAIN_NAME}|g" \
	/etc/nginx/conf.d/https.conf
ENTRYPOINT	[ "nginx", "-g", "daemon off;" ]