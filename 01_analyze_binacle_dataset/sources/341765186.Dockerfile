FROM mongo:3.4.1

COPY ./mongod.conf /etc/mongod.conf

ENTRYPOINT ["mongod", "--dbpath", "/data/mongodb"]
