from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

SQLALCHEMY_DATABASE_URL = "sqlite:///./pypistats.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


def get_db():
    """
    Should pass into ``Depends`` type hint in fastapi views that require db access; will ensure proper management of
    the db session.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_base():
    """ Get Base after registering the models to ensure imports happen in correct order"""
    # from .models import whatever
    return Base
