FROM python:2.7.13
ADD snippet.py snippet.py
RUN ["pip", "install", "flask"]
RUN ["pip", "install", "logging"]
RUN ["pip", "install", "sqlalchemy"]
RUN ["pip", "install", "alembic"]
CMD ["python", "snippet.py"]