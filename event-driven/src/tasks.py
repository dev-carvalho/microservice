#---
# Author: Marcos Antonio de Carvalho (maio/2023)
# Descr.: API Tasks define as Ações de processamento para
#         os Eventos a ser processados pelos workers.
#---
# https://www.youtube.com/watch?v=ig9hbt-yKkM&t=12s

#import logging

import celery_config

from celery import Celery

#logger = logging.getLogger(__name__)

app_tasks = Celery('tasks', broker="pyamqp://owl:owl@10.10.10.1")

#task_routes = ([
#    ('vamos.tasks.*', {'queue': 'too_long_queue'}),
##    ('web.tasks.*', {'queue': 'web'}),
#    (re.compile(r'(video|image)\.tasks\..*'), {'queue': 'media'}),
#],)

# Disponibilidade e Confiabilidade
# Tratamento de Falhas no processamento do Celery

##----------------##
##  SIMPLE TASKS  ##
##----------------##

@app_tasks.task(
  # queue='priority_queue', # Fila de destino da task
  max_retry=5,              # Tentará no máximo 5 vezes
  default_retry_delay=20,   # Tempo entre as tentativas
)
def hello(nome: str):
  return "hello {}".format(nome)

##------------------##
##  TASKS TOO LONG  ##
##------------------##

@app_tasks.task(
  queue='too_long_queue', # Fila de destino da task
  max_retry=5,            # Tentará no máximo 5 vezes
  default_retry_delay=20, # Tempo entre as tentativas
 )
# Serie de Fibonacci
def fib(n):
  if n == 0 or n == 1:
    return n
  return fib(n-1) + fib(n-2)



# docker exec -it worker  sh -c "/bin/bash"

# celery -A tasks worker --hostname tasks.%h --loglevel=info -Q priority_queue
# celery -A chains worker --hostname chains.%h --loglevel=info -Q priority_queue

# docker run -d --name broker -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=owl -e RABBITMQ_DEFAULT_PASS=owl rabbitmq:3-management-alpine

# pip install celery
# celery -A tasks worker --hostname teste.%h --loglevel=info --pool=solo
# celery -A tasks worker --hostname teste.%h --loglevel=info -Q priority_queue
# Obs.: Após alterações no código tem que reiniciar 


# pip install flower
# celery -A tasks flower --address=127.0.0.1 --port=5566
# celery -A tasks flower --address=127.0.0.1 --port=5566 --basic_auth=koruja:koruja,kalango:kalango,user:password
# Depois visite: http://127.0.0.1:5566

  