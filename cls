#!/usr/bin/zsh

figlet "Removing... Containers" | docker container rm -f $(docker container ls -qa)
figlet "Removing... Images"     | docker image     rm -f $(docker image ls -qa)
figlet "Removing... Networks"   | docker network   rm -f $(docker network ls)

