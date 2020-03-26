FROM mongo:3.7.1

COPY ./menu.json /docker-entrypoint-initdb.d/
COPY ./import.sh /docker-entrypoint-initdb.d/
COPY ./addUser.js /docker-entrypoint-initdb.d/
