#---
# Author: Marcos Antonio de Carvalho (maio/2023)
# Descr.: API Postman recebe as solicitações para processamento 
#         das tasks assíncrono a ser distribuído aos workers.
#---

##-----------##
##  POSTMAN  ##
##-----------##

# Muito util para disparar tarefas longas para outros Microsserviços 
# realizar a medida que vão chegando, de modo a não comprometer a 
# performance do Microsserviço corrente de atendimento direto ao usuário.


#from kombu import Queue

# Servidor ASGI (WebServer)
import uvicorn

# Biblioteca de API Rest
from fastapi import FastAPI
from fastapi.responses import HTMLResponse

# Obrigatório importar a função
#from tasks import hello
from tasks    import * 
from chains   import * 
#from too_long import * 

app_events = FastAPI(title="Python, FastAPI, and Docker")

@app_events.get("/config/", response_class=HTMLResponse)
async def show_config():
    html_content = """
    <html>
        <head>
            <title>Event Driven Architecture</title>
        </head>
        <body>
            <h1>Celery Configuration</h1>
            ......
        </body>
    </html>
    """
    return HTMLResponse(content=html_content, status_code=200)

@app_events.get("/")
def read_root():
    return {"Microservice:": "Postman"}

# Roteamento do Evento
@app_events.get("/test")
def read_root():
    # Ações (tasks) do Evento
    hello.delay("Marcos Antonio de Carvalho")
    # Ações em cadeia pipeline (chains) do Evento
    c.delay()
    # retorno da função do Evento
    fib.delay(21)
    return {"celery:": "postman"}


# Ativa o serviço em produção
# Isso aqui eu aprendi perguntando para o chatGPT ...  kkk
if __name__ == '__main__':
    uvicorn.run(app_events, host="0.0.0.0", port=8000, log_level="info")








