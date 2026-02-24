from fastapi import FastAPI
from fastapi import APIRouter
from sqlalchemy import text
from golf_app.db.session import engine
from golf_app.schemas.all_players_schema import AllPlayers

router = APIRouter()  # Define router here

# Route to return user information for profile page or viewing a users stats
@router.get("/players") #, response_model=list[AllPlayers]
def get_user_info():
    try:
        with engine.connect() as conn:
            result = conn.execute(
                text("SELECT * FROM golf.players;")
            )
            
            return [dict(row._mapping) for row in result] # Iteration = consumption of DS
            
    except Exception as e:
        print("DB connection failed:", e)