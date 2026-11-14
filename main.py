from fastapi import FastAPI
from routers import applications

app = FastAPI()
app.include_router(applications.router)