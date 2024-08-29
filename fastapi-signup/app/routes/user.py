from fastapi import APIRouter, Depends, HTTPException
from app.database import SessionLocal
from app import schemas, crud
from sqlalchemy.orm import Session

routers = APIRouter(
    prefix="/user",
    tags=["users"],
    responses={404: {"Description":"Not Found"}}
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@routers.post("/signup/", response_model=schemas.User)
def signup(user: schemas.UserCreate, db: Session = Depends(get_db)):
    db_user = crud.get_user_by_email(db=db, email=user.email)
    if db_user:
        raise HTTPException(400, "User already exists")
    db_user = crud.create_user(db=db, user=user)