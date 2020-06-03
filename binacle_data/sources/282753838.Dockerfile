FROM haskell:8.2.1

WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y libleveldb-dev leveldb-doc openssh-client expat libexpat1-dev libpq-dev postgresql postgresql-contrib
COPY ./config ./config
COPY ./uplink /usr/bin/uplink


