from sqlalchemy import text
from database import engine

with engine.connect() as connection:
    result = connection.execute(
        text("SELECT COUNT(*) FROM companies")
    )

    print(result.scalar_one())