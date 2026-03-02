import redis.asyncio as redis
import json

redis_client = redis.Redis(
    host="localhost",
    port=6379,
    decode_responses=True  # returns strings not bytes
)

async def get_cache(key: str):
    data = await redis_client.get(key)
    if data:
        return json.loads(data)
    return None


async def set_cache(key: str, value, ttl: int = 60):
    print('running')
    await redis_client.set(
        key,
        json.dumps(value),
        ex=ttl  # seconds before expiration
    )


