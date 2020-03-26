FROM mongo

RUN mkdir -p /var/log/mongodb

CMD ["/bin/sh", "-c", "mongod | tee /var/log/mongodb/mongodb.log"]
