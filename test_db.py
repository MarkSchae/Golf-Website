from sqlalchemy import text
from golf_app.db.session import engine

try:
    with engine.connect() as conn:
        result = conn.execute(
            text("SELECT * FROM golf.rounds LIMIT 5;")
        )

        for row in result:
            print(row)

except Exception as e:
    print("DB connection failed:", e)

