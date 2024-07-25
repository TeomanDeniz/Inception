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
RUN apt -y update && apt -y upgrade
RUN apt -y install nodejs npm
RUN npm set timeout=60000
RUN npm set fetch-retries=5
RUN npm config set fetch-retry-mintimeout 20000
RUN npm config set fetch-retry-maxtimeout 120000
RUN npm cache clean --force
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./conf/package*.json .
RUN npm install
RUN npm i react-scripts
RUN mkdir -p /usr/src/app/public
COPY ./srcs/public/* /usr/src/app/public/
RUN mkdir -p /usr/src/app/src
COPY ./srcs/src/* /usr/src/app/src/
ENTRYPOINT	[ "npm", "start" ]
