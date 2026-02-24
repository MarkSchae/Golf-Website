from fastapi import FastAPI
from fastapi import APIRouter
from sqlalchemy import text
from golf_app.db.session import engine
from golf_app.schemas.user_profile_schema import UserProfile

router = APIRouter()  # Define router here

# Route to return user information for profile page or viewing a users stats
@router.get("/user_profile", response_model=list[UserProfile]) #
def get_user_info():
    try:
        with engine.connect() as conn:
            result = conn.execute(
                text("""select p.*, avg(r.score) as all_rounds_avg,
                    min(r.score) as best_ever_score
                    from golf.players p
                    left join golf.rounds r on r.player_id = p.player_id
                    group by p.player_id;""" 
            )) 
            return [dict(row._mapping) for row in result] # Iteration = consumption of DS
            
    except Exception as e:
        print("DB connection failed:", e)