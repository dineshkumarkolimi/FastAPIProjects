mkdir app
mkdir app/routes
mkdir alembic
echo 'FROM python:3.10-slim\nWORKDIR /app\nCOPY requirements.txt .\nRUN \nCOPY . .\nCMD[] \n' > Dockerfile
touch alembic.ini
touch docker-compose.yaml
echo 'fastapi==0.95.2\nuvicorn[standard]==0.23.2\nsqlalchemy==2.0.20\nalembic==1.11.1\npydantic\npsycopg2-binary\npasslib\n' > requirements.txt
touch .env
touch app/__init__.py
touch app/routes/__init__.py
echo 'from fastapi import FastAPI\nfrom .models import Base\nfrom .database import engine\nfrom app.routers import user\n\nBase.metadata.create_all(bind=engine)\n\napp = FastAPI()\napp.include_router(user.router)' > app/main.py
echo 'from .database import Base\nfrom sqlalchemy import Column, Integer, String\n' > app/models.py
echo 'from pydating import BaseModel\n' > app/schemas.py
echo 'from sqlalchemy.orm import Session\nfrom . import models, schemas\nfrom passlib.context import CryptContext\n\npwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")\n' > app/crud.py
echo 'from sqlalchemy import create_engine\nfrom sqlalchemy.ext.declarative import declarative_base\nfrom sqlalchemy.orm import sessionmaker\nimport os\n\nDATABASEURL = os.getenv(DATABASE_URL, 'postgresql://postgres:password@localhost/postgres')\n\nengine = \nSessionLocal = sessionmaker(autoflush=, autocommit=, bind=engine)\nBase = \n' > app/database.py

echo "from fastapi import APIRouter, Depends, HTTPException\nfrom app.database import SessionLocal\nfrom app import schemas, crud\nfrom sqlalchemy.orm import Session\n\nrouters = APIRouter(\n    prefix="/<modulename>",\n    tags=["<modulename>"],\n    responses={404: {"Description":"Not Found"}}\n)\n" > app/routes/rename_route.py