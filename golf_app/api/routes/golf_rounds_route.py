from fastapi import FastAPI
from fastapi import APIRouter
from sqlalchemy import text
from golf_app.db.session import engine
from golf_app.schemas.all_rounds_schema import AllGolfRoundsResponse
from golf_app.schemas.all_players_schema import AllPlayers

router = APIRouter()  # Define router here

@router.get("/all_rounds", response_model=list[AllGolfRoundsResponse])
def get_all_rounds():
    try:
        with engine.connect() as conn:
            result = conn.execute(
                text("SELECT * FROM golf.rounds;")
            )
            
            return [dict(row._mapping) for row in result] # Iteration = consumption of DS
                

    except Exception as e:
        print("DB connection failed:", e)

# Option for improved swaggerdocs 
"""
@router.get("/", response_model=List[AllGolfRoundsResponse])
def get_rounds(
    limit: int = Query(5, ge=1, le=100),       # Optional limit param, 1–100
    player: Optional[str] = Query(None)        # Optional player name filter
):

    # Return golf rounds, optionally filtered by player, limited by `limit`.

    try:
        with engine.connect() as conn:
            sql = "SELECT * FROM golf.rounds"
            if player:
                sql += " WHERE player_name = :player"
            sql += " LIMIT :limit"
            
            result = conn.execute(
                text(sql),
                {"player": player, "limit": limit}
            )
            
            return [dict(row._mapping) for row in result]

    except Exception as e:
        # Proper HTTP response if DB fails
        raise HTTPException(status_code=500, detail="Database connection failed")
"""

