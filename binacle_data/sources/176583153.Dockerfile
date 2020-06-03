FROM postgres:9.3
ADD fix-acl.sh /docker-entrypoint-initdb.d/
