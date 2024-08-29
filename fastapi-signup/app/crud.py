from sqlalchemy.orm import Session
from . import models, schemas
from passlib.context import CryptContext

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_user_by_email(db: Session, email: str):
    db_user = db.query(models.User).filter(models.User.email == email).first()
    return db_user

def create_user(db: Session, user: schemas.UserCreate):
    hashed_password = pwd_context.hash(user.password)
    # Create a new User instance with the given data
    db_user = models.User(username=user.username, password=hashed_password, email=user.email) 
    db.add(db_user) # Stage the new user for insertion
    db.commit() # Commit the transaction, saving the new user to the database
    db.refresh(db_user) # Refresh the db_user object with the latest data from the database
    return db_user