FROM python:3.6

WORKDIR /app

ADD /server/config/requirements.txt /app/config/requirements.txt

RUN pip install -r config/requirements.txt

ADD . /app

EXPOSE 8000

CMD ["python", "server/manage.py", "runserver", "0.0.0.0:8000"]