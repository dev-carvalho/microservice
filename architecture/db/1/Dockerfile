# Dockerfile - Alpine linux, multiestágio
# https://www.blueshoe.io/blog/strategies-for-slim-docker-images/#dockerfile-5


##---------------------------##
##    FASE REQUERIMENTOS     ##
##  COMPILAÇÃO E CONSTRUÇÃO  ##
##---------------------------##

# requirements stage (Fase Requerimentos)
# imagem base do Python 'alpine' 
#
# python:<version>-alpine
# Esta imagem é baseada no popular projeto Alpine Linux, disponível na imagem alpine oficial. O Alpine 
# Linux é muito menor do que a maioria das imagens de base de distribuição (~ 5 MB) e, portanto, leva a 
# imagens muito mais slim em geral.
#
# Essa variante é útil quando o tamanho da imagem final menor possível é sua principal preocupação.
#
FROM python:3.8-alpine as base
FROM base as builder

# Configura Variáveis de Ambiente
# -------------------------------
# PYTHONDONTWRITEBYTECODE: Impede que o Python grave arquivos pyc no disco 
# (equivalente à opção python -B)
ENV PYTHONDONTWRITEBYTECODE 1
# PYTHONUNBUFFERED: Impede que o Python armazene em buffer stdout e stderr 
# (equivalente a opção python -u)
ENV PYTHONUNBUFFERED 1

# Diretório de instalação
RUN mkdir /install
WORKDIR /install

# Bibliotecas necessárias do Python
COPY requirements.txt /requirements.txt

# Pré-requisitos
#  - GNU Compiler Collection, que não está automaticamente disponível na Alpine.
#  - Deve ser distribuída com musl libc e não com glibc
RUN apk update && apk add  --no-cache --virtual .build-deps  gcc python3-dev musl-dev linux-headers postgresql-dev && \
    apk --no-cache add libpq && \
    apk add --no-cache --upgrade bash && \
    pip install --prefix=/install -r /requirements.txt && \
    apk del .build-deps # remoção de dependências de compilação





##--------------##
##  FASE FINAL  ##
##--------------##

# final stage (Fase Final)
FROM base
 
# Copia o conteúdo do diretório /install da primeira etapa
COPY --from=builder /install /usr/local

# Copia o código da aplicação
COPY src /app

# Diretório da aplicação
WORKDIR /app

CMD ["python","--version"]
