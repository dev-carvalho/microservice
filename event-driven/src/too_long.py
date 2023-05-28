#---
# Author: Marcos Antonio de Carvalho (maio/2023)
# Descr.: API Tasks define as Ações de processamento para
#         os Eventos a ser processados pelos workers.
#---
# https://www.youtube.com/watch?v=ig9hbt-yKkM&t=12s

##------------##
##  TOO LONG  ##
##------------##

#import logging
#import config

from celery import Celery

#logger = logging.getLogger(__name__)

#app_too_long = Celery('too_long', broker="pyamqp://owl:owl@10.10.10.1")
app_too_long = Celery('long', broker="pyamqp://owl:owl@10.10.10.1")

@app_too_long.task(
  queue='too_long_queue', # Fila de destino da task
  max_retry=5,            # Tentará no máximo 5 vezes
  default_retry_delay=20, # Tempo entre as tentativas
 )
# Serie de Fibonacci
def fib(n):
  if n == 0 or n == 1:
    return n
  return fib(n-1) + fib(n-2)


