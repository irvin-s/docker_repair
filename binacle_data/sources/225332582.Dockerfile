FROM mongo:3.4
ADD ./init.js /docker-entrypoint-initdb.d/
