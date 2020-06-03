FROM python:3.7-stretch AS django

WORKDIR /opt/my-web-app/

RUN apt-get update \
    && apt-get install \
        --no-install-recommends --yes \
        build-essential libpq-dev \
    && true

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt \
    && true

COPY ./mywebapp /opt/my-web-app/mywebapp
COPY ./deploy /opt/my-web-app/deploy
COPY ./manage.py /opt/my-web-app/manage.py

ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    DJANGO_SETTINGS_MODULE=deploy.settings

CMD ["/opt/my-web-app/deploy/run.sh"]

FROM django AS celery
CMD ["celery", "-A", "mywebapp", "worker", "--loglevel=info"]
