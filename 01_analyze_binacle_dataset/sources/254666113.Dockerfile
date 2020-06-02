FROM mongo:latest
MAINTAINER Prady <pradylibrary@gmail.com>

ENV MONGO_INITDB_DATABASE cloud

ADD create-user.js /docker-entrypoint-initdb.d/

EXPOSE 27017