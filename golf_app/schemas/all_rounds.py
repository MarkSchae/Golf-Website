from pydantic import BaseModel
from datetime import date 

class AllGolfRoundsResponse(BaseModel):
    course_name: str 
    player_name: str 
    score: int 
    date_played: date 
