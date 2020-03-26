FROM python:3.6
ENV PYTHONUNBUFFERED 1
RUN mkdir /app
WORKDIR  /app
RUN apt-get update && apt-get install -y sqlite3
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app

EXPOSE 8001
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]