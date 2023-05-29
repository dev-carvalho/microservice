<div style="display: inline_block">
  <img align="right" alt="Dev-pic" style="border-radius: 50%; width: 50%; height:auto;" src="https://github.com/dev-carvalho/python/blob/main/py-docker/image/microservices%20(no%20HA).PNG">
</div>

## Descrição do Projeto
Construção de uma infra-estrutura para suportar o ecosistema de multiplos microsserviços contruidos com diversas tecnologias. 

Utilizaremos nesse projeto para os Micro-serviços:
- Llinguagem Python;
- Biblioteca FastAPI (Padrão REST);
- Banco de Dados PostGreSQL e sua Administração (pgadmin);

<br>

### Estrutura de Diretório

```
.
├── README.md
├── docker-compose.yml
├── image
│   └── microservices (no HA).PNG
├── ms-1
│   ├── Dockerfile
│   └── main.py
├── ms-2
│   ├── Dockerfile
│   └── main.py
├── rebuild
└── requirements.pip
```

<br>

## Construindo a Imagem da Aplicação via Dockerfile

`docker build -t img-app .`

### Iniciando o contêiner Docker

`docker run -d --rm --name app -p 80:80 img-app`

- Para habilitar a execução do contêiner na inicialização e habilitar reinicializações em falhas<br>
`docker run -d --restart on-failure --name app -p 80:80 img-app`

<br>

## Construindo da Infra-estrutura necessária para a Aplicação

- UP/Levanta a infra-estrutura: <br>
`docker-compose up -d`

- DOWN/Derubar a infra-estrutura da Aplicação: <br>
`docker-compose down`

<br>

## Acesso ao shell do container 

`#  docker container exec -it ms-1  /bin/sh`

<br>

## Micro-Serviço via FastAPI do Phython 

### Documentação interativa da API que utiliza a FatsAPI

 Acesse http://127.0.0.1/docs (ou equivalente, usando seu host Docker).

<br>
