from sqlalchemy import create_engine

DATABASE_URL = "postgresql+psycopg:///job_tracker"

engine = create_engine(DATABASE_URL)

