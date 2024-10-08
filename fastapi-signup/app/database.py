from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

DATABASE_URL = os.getenv('DATABASE_URL', 'postgresql://postgres:postgres@localhost:5432/postgres')

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autoflush=True, autocommit=False, bind=engine)
Base = declarative_base()