FROM python:3.7-alpine

ENV PYCURL_SSL_LIBRARY=openssl \
    PYTHONPATH=. \
    DOCKER=True

# compile requirements for some python libraries
RUN apk --no-cache add curl-dev bash postgresql-dev \
    build-base libffi-dev libressl-dev tini && \
    python3 -m pip install invoke alembic poetry

# install python reqs
COPY ["pyproject.toml", "pyproject.lock", "/app/"]
WORKDIR /app

RUN export PYCURL_SSL_LIBRARY=openssl && \
    poetry config settings.virtualenvs.create false && \
    poetry install -vvv --no-dev


# build frontend
COPY tmeister/static /app/tmeister/static
RUN apk --no-cache add nodejs npm git && \
    cd /app/tmeister/static && \
    npm install && \
    npm run build && \
    apk --no-cache del nodejs git && \
    rm -rf node_modules spec src bin &&  \
    cd /app


EXPOSE 8445
CMD ["tini", "./startup.sh"]
COPY . /app
