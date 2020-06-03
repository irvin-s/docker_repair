FROM ckan/postgresql:latest
LABEL maintainer "codefordc"

COPY ./initdb.sh /docker-entrypoint-initdb.d/initdb.sh