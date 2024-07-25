# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: hdeniz <Discord:@teomandeniz>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/24 10:48:13 by hdeniz            #+#    #+#              #
#    Updated: 2024/07/20 16:31:01 by hdeniz           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: folders volumes up

folders:
	@test -d /home/$(USER) || mkdir /home/$(USER)
	@test -d /home/$(USER)/data || mkdir /home/$(USER)/data
	@test -d /home/$(USER)/data/wordpress || mkdir /home/$(USER)/data/wordpress
	@test -d /home/$(USER)/data/mariadb || mkdir /home/$(USER)/data/mariadb

volumes:
	@docker volume create --driver local --opt type=none --opt \
		device=/home/$(USER)/data/wordpress --opt o=bind wordpress
	@mkdir -p /home/$(USER)/data/mariadb
	@docker volume create --driver local --opt type=none \
		--opt device=/home/$(USER)/data/mariadb --opt o=bind mariadb
	@mkdir -p /home/$(USER)/data/static
	@docker volume create --driver local --opt type=none \
		--opt device=/home/$(USER)/data/static --opt o=bind static

up:
	@docker-compose -f ./srcs/docker-compose.yml up --build

down:
	@docker-compose -f srcs/docker-compose.yml down

clean: down
	@docker system prune -af
	@test -d /home/$(USER)/data && rm -rf /home/$(USER)/data

re: down up

PHONY: all clean re up down
