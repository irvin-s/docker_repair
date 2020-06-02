FROM python:2.7

RUN apt-get update && apt-get install -y \
        gcc \
        gettext \
        sqlite3 \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN pip install --no-cache-dir -r requirements/dev.txt

EXPOSE 8000
ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]
