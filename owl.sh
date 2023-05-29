#!/usr/bin/zsh

#
# Reconstrução da infra-estrura de "Microservice no HA"
#

# HELP - Informações de Ajuda
if [ -z "$1" ] || [ $1 = -h ] || [ $1 = --help ]
then
    echo ""
    echo "Usage: owl microservice COMMAND"
    echo ""
    echo "Commands:"
    echo "  up       Ativa o microsserviço"
    echo "  down     Desativa o microsserviço"
    echo "  restart  Desativa e ativa novamente o microsserviço"
    echo "  reset    Reconstroi o microsserviço (Containers, Images and Networks)"
    echo "  status   Relatório de status do microsserviço"
    echo ""
    echo "Global Options:"
    echo "  -h, --help"
    echo "  -v, --version"
    echo ""
fi


# Descobre os microservicees Docker Compose e 
# coloca em uma lista.

# Setup do DB de Micoroserviços
declare -a db_microservices  # indexed
db_microservices[1]=all # Todos os Micoserviços
n=1
# Descoberta dos Microserviços
for file_docker_compose in $(ls docker-compose.ms*)
do 
  n=$n+1
  microservice=$(echo $file_docker_compose | cut -d "." -f 3)
  db_microservices[n]=$microservice
done


### DEBUG
# Mostra os dados do DB de Microserviços
#echo "${#db_microservices[@]} elementos"
##n=0
#for microservice in "${db_microservices[@]}"
#  do
#    #$n=$n+1
#    echo "** $microservice"
#  done

echo "OWL - Microservices Architecture"
echo "Version 0.1"
echo ""


##----------##
##  PARSER  ##
##----------##

# Banco de dados de comandos validos
db_commands=(up down restart reset status)

# Tokens passados na linha de comando
tokens=($@) 
#echo "($tokens)"

valid_command() {
  local command
  # Pesquisa se o token é um Comando passados
  for command in "${db_commands[@]}"
  do
    if [ "$1" = "$command" ]
    then 
      return 0 # Encontrou! 
    fi
  done
  return 1 # Não encontrou!
}

valid_service() {
  # Pesquisa no DB de Microserviços
  for microservice in "${db_microservices[@]}"
  do
    if [ "$1" = "$microservice" ]
    then 
      return 0 # Encontrou! 
    fi
  done
  return 1 # Não encontrou!
}

first=true
# Processamento dos TOKENS
for token in "${tokens[@]}"
do
  valid_command $token
  # se for comando
  if [ $? -eq 0 ] 
  then 
    first=false
    cmd_token=$token
    cmd_activated="$cmd_activated $cmd_token"
    declare -A command  # array associativo
  else
    # Se primeiro token e não é um Comando 
    if [ $first = true ]
    then 
      echo "Error: Unknown Command '$token'"
      exit 1
    fi
    # Validação do Microsserviço
    valid_service $token
    # se existe o Microsserviço
    if [ $? -eq 1 ] 
    then 
      # Microsserviço INVALIDO
      echo "$cmd_token: Unknown MicrosService '$token'"
      echo "\nValid Microservices: $db_microservices"
      exit 1
    fi
    command[$cmd_token]="$command[$cmd_token] $token"
  fi
done

# Converte para array
command_to_process=( `echo $cmd_activated` ) 


##-----------##
##  ACTIONS  ##
##-----------##

up() {
  # echo "($services_to_process)"
  echo -ne "UP:"
  for service in $services_to_process
  do
    # Removendo CONTAINER
    echo -ne " $service"
    #docker container rm -f $service
    docker compose  -f docker-compose.ms.$service.yml up -d 
  done
  echo ""
}

down() {
  echo "($services_to_process)"
  for service in $services_to_process
  do
    # Removendo CONTAINER
    echo "DONW: Removing: $service"
    #docker container rm -f $service
  done
}

reset() {
    echo "Hello reset()";
}


##-----------##
##  PROCESS  ##
##-----------##

# Processamento dos COMANDOS
for current in "${command_to_process[@]}"
do
  # echo "-- $current"
  case $current in

    up)     
      services_to_process=( `echo $command[up]` )
      up;;

    down) 
      services_to_process=( `echo $command[down]` )
      down;;
        
    *)
      echo "Unknown Command: $1"
      exit 1;;

  esac
done


exit




if [[ $1 =~ ^(-h|--help) ]]
then
    echo ""
    echo "Usage: krv microservice COMMAND"
    echo ""
    echo "Commands:"
    echo "  up        Ativa o microservicee"
    echo "  down      Desativa o microservicee"
    echo "  reset     Reconstroi o microservicee (Containers, Images and Networks)"
    echo ""
    echo "Global Options:"
    echo "-h, --help"
    echo "-v, --version"
    echo ""
fi

#docker-compose down

# Removendo CONTAINER
docker container rm -f  ms-1
docker container rm -f  ms-2

# Removendo IMAGE
docker image     rm -f  $(docker image ls -q py-docker_ms-1) 
docker image     rm -f  $(docker image ls -q py-docker_ms-2) 
 

# docker image   rm -f $(docker image ls -qa)
# docker container rm -f $(docker container ls -qa)
# docker network   rm -f $(docker network ls)

#FROM python:3.11.1-slim as builder

docker-compose up -d
docker-compose ps

docker build -t py-pg .
docker run -d --name pg -p 8080:802 py-pg 
docker run -it --name pg  py-pg 

 docker container exec -it py-pg  /bin/bash


docker container exec -it ms-1  /bin/bash


Funcionou!
docker build -t py-pg .
docker run -d --name pg -p 8080:80 py-pg 
docker run -it py-pg  /bin/sh

docker-compose -f docker-compose.global.admin.yml -f docker-compose.global.network.yml -f docker-compose.global.volume.yml  -f docker-compose.ms.1.yml -f docker-compose.ms.2.yml up -d 



/usr/local/bin/docker-entrypoint.sh


docker-compose build service1 service2 --no-cache
