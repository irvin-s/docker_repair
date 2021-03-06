FROM python:3.5

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y cron rsyslog netcat

# Requirements have to be pulled and installed here, otherwise caching won't work
COPY ./requirements /requirements

RUN pip install -r /requirements/production.txt

RUN groupadd -r django && useradd -r -g django django
COPY . /app
RUN chown -R django /app

COPY ./compose/django/gunicorn.sh /gunicorn.sh
COPY ./compose/django/entrypoint.sh /entrypoint.sh
COPY ./compose/django/cron.sh /cron.sh
COPY ./compose/wait_to_start.sh /wait_to_start.sh
RUN sed -i 's/\r//' /entrypoint.sh
RUN sed -i 's/\r//' /gunicorn.sh
RUN sed -i 's/\r//' /cron.sh
RUN chmod +x /entrypoint.sh && chown django /entrypoint.sh
RUN chmod +x /gunicorn.sh && chown django /gunicorn.sh
RUN chmod +x /cron.sh && chown django /cron.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
