FROM mdillon/postgis:9.4
MAINTAINER Kitware, Inc. <kitware@kitware.com>

COPY ./ktile_test_setup.sh /docker-entrypoint-initdb.d/ktile_test_setup.sh
