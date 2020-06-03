FROM apache/couchdb:2.1.1

MAINTAINER Clemens Stolle klaemo@apache.org

COPY lucene-proxy.ini /usr/local/etc/couchdb/local.d/
