FROM python:3-alpine

WORKDIR /usr/src/app

COPY . .

RUN pip install -r requirements.txt

RUN python manage.py migrate

EXPOSE 8000

ENTRYPOINT python manage.py runserver 0.0.0.0:8000
