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
RUN apt -y install redis-server redis-tools
RUN mkdir -p /run/redis
RUN chmod 755 /run/redis
RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
RUN sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf
ENTRYPOINT  [ "redis-server", "--protected-mode", "no" ]