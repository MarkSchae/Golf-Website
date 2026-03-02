from fastapi import FastAPI
from fastapi import APIRouter
from sqlalchemy import text
from golf_app.db.session import engine
from golf_app.schemas.leaderboard_schema import LeaderboardAll
from golf_app.core.cache import get_cache, set_cache, redis_client
from fastapi import Request
import json

router = APIRouter()  # Define router here

# Storing leaderboard filtering options in redis for cache of frequent filter requests
# Building the cach key for redis storage
# GET /leaderboard?gender=female
# path: /leaderboard query string: gender=female
# request.query_params["gender"]  # "female" fastApi does this automatically

def leaderboard_cache_key(player_gender: str):
    return f"leaderboard:{player_gender}"

# Route to return user information for profile page or viewing a users stats
@router.get("/leaderboard", response_model=list[LeaderboardAll]) #
async def get_leaderboard(player_gender: str | None = None):
    print(player_gender)
    # Only use cache if filter exists
    if player_gender:
        key = leaderboard_cache_key(player_gender)

        cached = await get_cache(key)
        if cached:
            print("CACHE HIT")
            return cached

    print("DB QUERY")

    query = """
    SELECT p.player_name, MIN(r.score) AS best
    FROM golf.players p
    JOIN golf.rounds r ON p.player_id = r.player_id
    """

    params = {}

    if player_gender:
        query += " WHERE p.player_gender = :gender"
        params["gender"] = player_gender

    query += """
    GROUP BY p.player_name
    ORDER BY best ASC
    """

    # Actual querry to the db returned at python object, row.map convert to json
    try:
        with engine.connect() as conn:
            result = conn.execute(text(query), params)
            data = [dict(row._mapping) for row in result]
            # Cache only filtered results
            if player_gender:
                await set_cache(key, data, ttl=120)
                
            return data # Iteration = consumption of DS
            
    except Exception as e:
        print("DB connection failed:", e)
    
# Redis layer route for debuging
@router.get("/debug/redis")
async def redis_debug():
    keys = await redis_client.keys("leaderboard*")
    data = {}
    for key in keys:
        val = await redis_client.get(key)
        data[key] = json.loads(val)
    return data
