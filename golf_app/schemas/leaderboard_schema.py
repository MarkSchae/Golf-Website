from pydantic import BaseModel

class LeaderboardAll(BaseModel):
    player_name: str 
    best: int 
    # Rank