#---
# Author: Marcos Antonio de Carvalho (maio/2023)
# Descr.: API Tasks define as Ações de processamento para
#         os Eventos a ser processados pelos workers.
#---
# https://www.youtube.com/watch?v=ig9hbt-yKkM&t=12s

#import logging
#import config

from celery import Celery
from celery import chain

#logger = logging.getLogger(__name__)

app_chains = Celery('chains', broker="pyamqp://owl:owl@10.10.10.1")

##---------------##
##  CHAIN TASKS  ##
##---------------##

@app_chains.task(
  queue='chain_queue', # Fila de destino da task
  max_retry=5,            # Tentará no máximo 5 vezes
  retry_backoff=5,        # Tempo entre Tentativa exponencial: 5, 10, 15, 30 60,... 
)
def a(x):
  return x * 4

@app_chains.task(
  queue='chain_queue', # Fila de destino da task
  max_retry=5,            # Tentará no máximo 5 vezes
  retry_backoff=5,        # Tempo entre Tentativa exponencial: 5, 10, 15, 30 60,... 
)
def b(x,y):
  return x + y

@app_chains.task(
  queue='chain_queue', # Fila de destino da task
  max_retry=5,            # Tentará no máximo 5 vezes
  retry_backoff=10,       # Tempo entre Tentativa exponencial: 10, 20, 30, 60 120,... 
)
def c():
  # é um pipeline. 
  # O .s é de sequence, ou seja: sequência.
  chain(a.s(1), b.s(2))
  # result = chain(a.s(1), b.s(2))
  # return result
  #
  # b(a(1),2)  
  # É um pipeline! Veja que o resultado da primeira 
  # função entra como parametro na segumda função.
  #
  # Tolerância a falhas:
  # Cada uma das função vai repetir, se precisar ser 
  # alguma falha repetida.


