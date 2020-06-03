# Start from existing PostreSQL 10 Debian image
FROM postgres:10

MAINTAINER Mihai Criveti

# Update and install PostGIS
RUN apt-get update
RUN apt-get install --no-install-recommends --yes postgresql-10-postgis-2.4 postgresql-10-postgis-2.4-scripts postgresql-contrib

