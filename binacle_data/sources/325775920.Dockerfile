# Dockerize https://github.com/duo-labs/cloudmapper
# Author: https://github.com/sebastientaggart/
#
# Cloudmapper, from https://github.com/duo-labs/cloudmapper/ is a tool to
# visualize AWS infrastructure.
#
# This project pulls Cloudmapper and initializes it in a docker container.

FROM python:3.7-alpine

LABEL maintainer="https://github.com/sebastientaggart"

EXPOSE 8000
WORKDIR /opt/cloudmapper

# By default python buffers output, which prevents output to docker logs.  This
# disables the output buffering so logging works as expected.
ENV PYTHONUNBUFFERED=0

RUN apk --no-cache --virtual build-dependencies add \
autoconf \
automake \
libtool \
python-dev \
jq \
g++ \
make \
openblas \
openblas-dev \
freetype-dev \
libpng-dev \
git

RUN git clone https://github.com/duo-labs/cloudmapper.git .
RUN pip install pipenv && pipenv install
RUN pip install --upgrade awscli
#RUN chmod +x entrypoint.sh && touch config.json

VOLUME /opt/cloudmapper/web /opt/cloudmapper/account-data

COPY entrypoint.sh ./entrypoint.sh

COPY .env ./.env

# Keep the container alive for testing
#CMD tail -f /dev/null

CMD ["sh","entrypoint.sh"]

# Health Check.  Long interval is because it can take a long time to load data
# from AWS the first time this runs (TODO: don't run data load on run)
HEALTHCHECK --interval=5m --timeout=3s \
  CMD netstat -an | grep "0.0.0.0:8000" > /dev/null; if [ 0 != $? ]; then exit 1; fi;
