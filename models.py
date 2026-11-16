from sqlalchemy import Integer, Text, Identity, ForeignKey, CheckConstraint
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship

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
    
    applications: Mapped[list["ApplicationDB"]] = relationship(
        back_populates="company"
    )

class ApplicationDB(Base):
    __tablename__ = "applications"

    id:Mapped[int]=mapped_column(
        Integer,
        Identity(always=True),
        primary_key=True
    )

    company_id:Mapped[int]=mapped_column(
        Integer,
        ForeignKey("companies.id"),
        nullable=False
    )

    role:Mapped[str]=mapped_column(
        Text,
        nullable=False
    )

    status:Mapped[str]=mapped_column(
            Text,
            nullable=False
        )
    company: Mapped["CompanyDB"] = relationship(
    back_populates="applications")

    __table_args__ = (CheckConstraint(
        "status IN ('applied', 'interview', 'rejected')",
        name="check_application_status"
        ),
    )
    