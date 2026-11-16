from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, Field
from typing import Optional, Literal

from sqlalchemy.orm import Session
from sqlalchemy import select,join, func
from database import get_db
from models import ApplicationDB, CompanyDB

router=APIRouter(prefix="/applications")

ApplicationStatus = Literal["applied", "interview", "rejected"]

class Application(BaseModel):
    id : int = Field(ge = 0)
    company: str = Field(min_length=1)
    role : str = Field(min_length=1)
    status : ApplicationStatus 


class UpdateApplication(BaseModel):   
    company : Optional[str] = Field(default=None, min_length=1)
    role : Optional[str] = Field(default=None, min_length=1)
    status : ApplicationStatus | None = None

@router.post("",status_code = 201)
def create_application (application : Application):
    for current_application in applications:
        if current_application.id == application.id:
            raise HTTPException(
                status_code= 409,
                detail = "application already existed"
                )
    applications.append(application)
    return application

@router.get("",response_model=list[Application])
def get_applications(status : ApplicationStatus | None = None, company : str | None = None, session: Session=Depends(get_db)):
    statement = select(ApplicationDB)

    if status is not None:
        statement = statement.where(ApplicationDB.status == status)
        
    if company is not None:
        statement = statement.join(ApplicationDB.company).where(func.lower(CompanyDB.name)==company.lower())
    
    result = session.scalars(statement).all()

    responses = []
    for application in result:
        response = Application(
            id=application.id,
            company=application.company.name,
            role=application.role,
            status=application.status
            )
        responses.append(response)
    return responses

   

@router.get("/{application_id}")
def get_application_by_id(application_id : int):
    for application in applications:
        if application_id == application.id:
            return application

    raise HTTPException(
        status_code = 404,
        detail = "msg: application not found"
    )

@router.patch("/{application_id}")
def update_application(update : UpdateApplication, application_id : int):
    for application in applications:
        if application.id == application_id:
            data = update.model_dump(exclude_unset=True)
            for key, value in data.items():
                setattr(application,key,value)
            return application

    raise HTTPException(
            status_code = 404,
            detail = "msg: application not found"
        )

@router.delete("/{application_id}", status_code=204)
def delete_application(application_id : int):
    for application in applications:
        if application.id == application_id:
            applications.remove(application)
            return 

    raise HTTPException(
        status_code = 404,
        detail= "msg: application not found"
        )

