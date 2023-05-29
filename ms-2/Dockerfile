# Dockerfile - Debian Buster, multiestágio

# Autor: Marcos Antonio de Carvalho
# Descrição: Construção em vários estágios de container Docker
#            para aplicações em linguagem Python.

# Inspiração:
#  - https://testdriven.io/blog/docker-best-practices/
#  - https://fastapi.tiangolo.com/pt/deployment/docker/

# Use um estágio para compilar e construir seu aplicativo. Como apenas
# o estágio final é usado para criar a imagem, as dependências e ferramentas
# associadas à construção de seu aplicativo são descartadas, deixando uma 
# imagem enxuta e modular pronta para produção.

##---------------------------##
##    FASE REQUERIMENTOS     ##
##  COMPILAÇÃO E CONSTRUÇÃO  ##
##---------------------------##

# requirements stage (Fase Requerimentos)
# imagem base do Python 'slim' 
#
# python:<version>-slim
# Esta imagem não contém os pacotes comuns contidos na tag padrão e contém apenas os pacotes mínimos 
# necessários para executar python. A menos que você esteja trabalhando em um ambiente onde apenas a 
# pythonimagem será implantada e você tenha restrições de espaço, é altamente recomendável usar a imagem 
# padrão deste repositório.
#

FROM python:3.12.0a7-alpine3.17 as builder

# Diretório da aplicação
WORKDIR /code

# Configura Variáveis de Ambiente
# -------------------------------
# PYTHONDONTWRITEBYTECODE: Impede que o Python grave arquivos pyc no disco 
# (equivalente à opção python -B)
ENV PYTHONDONTWRITEBYTECODE 1
# PYTHONUNBUFFERED: Impede que o Python armazene em buffer stdout e stderr 
# (equivalente a opção python -u)
ENV PYTHONUNBUFFERED 1

#RUN apt-get update && apt-get install -y --no-install-recommends gcc
RUN apk update && apk add  --no-cache --virtual .build-deps  gcc python3-dev musl-dev 

# Lista dos requisitos minimos
COPY ./requirements.pip /code/requirements.pip

# Instala os requisitos minimos
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /code/wheels -r /code/requirements.pip
# O jeito acima é melhor!
#RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt


##--------------##
##  FASE FINAL  ##
##--------------##

# final stage (Fase Final)
FROM python:3.11.1-slim 

LABEL author="Marcos Antônio de Carvalho"
LABEL description="Micro-servico em Linguagem Python"
LABEL version="1.0"

# Diretório da aplicação
WORKDIR /code

COPY --from=builder /code/wheels /wheels
COPY --from=builder /code/requirements.pip .

RUN pip install --no-cache /wheels/*

# Código do projeto da aplicação
COPY ./ms-2 /code/app

# Incializa Aplicação 
# se a aplicação utilizar "uvicorn", ela deve carregá-lo
CMD ["python","app/main.py"]

# Inicia o WebServer e a apliacação
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
# uvicorn app.main:app --host 0.0.0.0 --port 80 --reload

# Se você está executando seu contêiner atrás de um Proxy de Terminação TLS (load balancer) 
# como Nginx ou Traefik, adicione a opção --proxy-headers, isso fará com que o Uvicorn confie 
# nos cabeçalhos enviados por esse proxy, informando que o aplicativo está sendo executado
#  atrás do HTTPS, etc.
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "1001", "--workers", "4", "--proxy-headers" ]

# RESUMO:
#  compilações de vários estágios podem diminuir o tamanho de suas imagens de produção,
#  ajudando você a economizar tempo e dinheiro. Além disso, isso simplificará seus 
#  contêineres de produção. Além disso, devido ao tamanho menor e à simplicidade, 
#  há uma superfície de ataque potencialmente menor.

##
# End.
