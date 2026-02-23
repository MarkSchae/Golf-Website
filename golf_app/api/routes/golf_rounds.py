from fastapi import FastAPI
from fastapi import APIRouter
from sqlalchemy import text
from golf_app.db.session import engine
from golf_app.schemas.all_rounds import AllGolfRoundsResponse

router = APIRouter()  # Define router here

@router.get("/", response_model=list[AllGolfRoundsResponse])
def root():
    #return {"message": "Hello, Golf Pro Web!"}
    try:
        with engine.connect() as conn:
            result = conn.execute(
                text("SELECT * FROM golf.rounds;")
            )
            
            return [dict(row._mapping) for row in result] # Iteration = consumption of DS
                

    except Exception as e:
        print("DB connection failed:", e)
