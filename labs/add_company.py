from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from database import engine
from models import CompanyDB

with Session(engine) as session:
    try:
        company = CompanyDB(name = "Amazon")
        session.add(company)
        session.commit()

    except IntegrityError:
        session.rollback()
        print("Company Already Exist")