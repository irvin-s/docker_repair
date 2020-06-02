FROM postgres:9.4
MAINTAINER "Rafael Gomes <rgomes@thoughtworks.com>"
ADD create_initial_sgdb_data.sh /docker-entrypoint-initdb.d/create_initial_sgdb_data.sh