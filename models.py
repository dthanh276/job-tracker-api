from sqlalchemy import Integer, Text, Identity
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class CompanyDB(Base):
    __tablename__ = "companies"

    id:Mapped[int] = mapped_column(
        Integer,
        Identity(always=True),
        primary_key=True
    )

    name:Mapped[str] = mapped_column(
        Text,
        nullable=False,
        unique= True
    )
