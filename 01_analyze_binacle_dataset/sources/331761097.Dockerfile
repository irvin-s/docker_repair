FROM python:3.6.0-slim
WORKDIR /app

ENV PYTHONUNBUFFERED=1

ADD requirements.txt /app/
RUN pip install -r /app/requirements.txt --no-cache-dir

RUN useradd {{cookiecutter.app_name}}
RUN chown -R {{cookiecutter.app_name}} /app
USER {{cookiecutter.app_name}}
COPY . /app
RUN ./manage.py collectstatic --no-input

