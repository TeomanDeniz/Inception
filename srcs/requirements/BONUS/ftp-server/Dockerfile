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
ARG FTP_USER
ARG FTP_PASSWORD
ENV FTP_USER=${FTP_USER}
ENV FTP_PASSWORD=${FTP_PASSWORD}
RUN apt -y update && apt -y upgrade
RUN apt -y install vsftpd ftp
COPY ./conf/vsftpd.conf /usr/local/bin/
COPY ./tools/init.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/init.sh
EXPOSE 20 21 21100-21110
ENTRYPOINT  [ "bash", "/usr/local/bin/init.sh" ]