FROM python:3.6.5
LABEL maintainer="shirakiya"

ENV PYTHONUNBUFFERED "0"
ENV RUN_MODE "production"
ENV PORT "8000"
ENV MYSQL_USER "root"
ENV MYSQL_PASSWORD ""
ENV MYSQL_HOST "localhost"
ENV AWS_XRAY_DAEMON_ADDRESS "127.0.0.1:2000"
ENV API_TOKEN ""
ENV GOOGLE_API_KEY ""
ENV SLACK_URL ""
ENV TWITTER_CONSUMER_KEY ""
ENV TWITTER_CONSUMER_SECRET ""
ENV TWITTER_ACCESS_TOKEN ""
ENV TWITTER_ACCESS_TOKEN_SECRET ""

COPY ./requirements.txt /app/
COPY ./requirements-deploy.txt /app/
COPY ./manage.py /app/
COPY ./app /app/app
COPY ./jaaxman /app/jaaxman
COPY ./uwsgi.ini /app/

WORKDIR /app

RUN pip install -U pip \
    && pip install --no-cache-dir -r requirements.txt \
    && mkdir -p /var/log/uwsgi

CMD ["/usr/local/bin/uwsgi", "--ini", "/app/uwsgi.ini"]
