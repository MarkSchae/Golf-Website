from fastapi import FastAPI
from golf_app.api.routes import golf_rounds_route, golf_players_route, golf_user_profile_route, golf_leaderboard_route

app = FastAPI(title="Golf Pro Web API")

# Include routers with paths and tags
app.include_router(golf_rounds_route.router, prefix="", tags=["Golf"])
app.include_router(golf_players_route.router, prefix="", tags=["Golf"])
app.include_router(golf_user_profile_route.router, prefix="", tags=["Golf"])
app.include_router(golf_leaderboard_route.router, prefix="", tags=["Golf"])




