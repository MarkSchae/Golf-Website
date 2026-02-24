from pydantic import BaseModel

class UserProfile(BaseModel):
    player_name: str 
    player_age: int 
    player_gender: str 
    age_started_golf: int 
    practice_sessions_week: int 
    fitted_clubs: bool 
    rounds_played_year: int 
    all_rounds_avg: float 
    best_ever_score: int 