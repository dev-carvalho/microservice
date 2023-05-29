# app/main.py

# Servidor ASGI (WebServer)
import uvicorn

# Biblioteca de API
from fastapi import FastAPI

app = FastAPI(title="Python, FastAPI, and Docker")

@app.get("/")
def read_root():
    return {"Microservice:": "ms-1"}


# Ativa o serviço em produção
# Isso aqui eu aprendi perguntando para o chatGPT
if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=80, log_level="info")
