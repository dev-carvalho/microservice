#!/bin/sh

# Naturamente as tarefas são distribuidas para todos 
# os WORKES de forma balanceado.

# Check se é Apine Linux
if [[ $(grep '^ID' /etc/os-release) = "ID=alpine" ]]
then
# Apine Linux
  CELERY=/home/user/.local/bin/celery
else
  # outro linux
  CELERY=celery
fi  

###
# Opções do Celery
# https://docs.celeryq.dev/en/stable/reference/cli.html
#
# -l, --loglevel <loglevel>
# Options
# DEBUG|INFO|WARNING|ERROR|CRITICAL|FATAL
#
# -f, --logfile <logfile>
#
# -Q, --queues <queues>
#
# -n, --hostname <hostname>
# Set custom hostname (e.g., ‘w1@%%h’). Expands: %%h (hostname), %%n (name) and %%d, (domain).
#
# --autoscale=<MAX>,<MIN>
# Aumenta automaticamente a quantidade de trabalhadores para 10 no pico e para 0 quando não há usuário.
#
# --concurrency
# Define estaticamento a quantidade de trabalhadores. 
#
# Ao usar, --autoscaleo número de processos é definido dinamicamente com valores máximos/mínimos
# que permitem que o trabalhador seja dimensionado de acordo com a carga e 
# ao usar --concurrency processos é definido estaticamente com um número fixo. 
# Portanto, usar esses dois juntos não faz sentido.
#
####

${CELERY} -A tasks worker  -l info -f common_%h.log   -Q celery         -n _common_%h   --autoscale=4,1 &
${CELERY} -A tasks worker  -l info -f too_long_%h.log -Q too_long_queue -n _too_long_%h --autoscale=4,1 &
${CELERY} -A chains worker -l info -f chains_%h.log   -Q chain_queue    -n _chains_%h   --autoscale=4,1 &

#${CELERY} -A tasks worker --loglevel=info -Q priority_queue --hostname tasks_priority_%h --autoscale=1,3 &

#celery worker -A proj_name -O fair -Q {queue_name}
# -P gevent --autoscale=32,16 --loglevel=INFO
# --logfile={queue_name}_celery.log

echo "Press [CTRL+C] to stop.."
while : 
do
	sleep 1
done

echo ""