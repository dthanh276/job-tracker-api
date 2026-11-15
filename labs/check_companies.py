from sqlalchemy import select
from sqlalchemy.orm import Session

from database import engine
from models import CompanyDB

with Session(engine) as session:
    statement = select(CompanyDB).where(CompanyDB.id == 1)

    company = session.scalars(statement).one_or_none()

    if company is not None:
        print(company.id, company.name)
    else:
        print("Company not found")