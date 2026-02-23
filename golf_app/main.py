from fastapi import FastAPI
from golf_app.api.routes import golf_rounds

app = FastAPI(title="Golf Pro Web API")

# Include routers with paths and tags
app.include_router(golf_rounds.router, prefix="", tags=["Golf"])

