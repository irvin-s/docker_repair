FROM python:3.6-stretch AS venv
WORKDIR /usr/src/app
COPY requirements.txt /usr/src/app/
RUN python3 -m venv venv
RUN venv/bin/pip install -r requirements.txt

FROM python:3.6-slim-stretch
RUN apt-get update && \
    apt-get -y install libmagic-dev && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app
COPY . /usr/src/app/
COPY --from=venv /usr/src/app/venv venv
RUN venv/bin/python manage.py collectstatic --no-input
CMD ["venv/bin/gunicorn", "linksight.wsgi", "-c", "deploy/gunicorn.py"]
EXPOSE 8000
