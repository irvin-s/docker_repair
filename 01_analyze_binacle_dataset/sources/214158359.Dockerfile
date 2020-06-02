FROM python:3.6.1-slim

RUN mkdir /app

COPY /create-db-dump.sh /app/create-db-dump.sh
COPY /upload-dump-to-s3.py /app/upload-dump-to-s3.py

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends gnupg2 jq wget vim && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
      apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-9.5 && \
    pip install requests

CMD ["tail", "-f", "/dev/null"]
