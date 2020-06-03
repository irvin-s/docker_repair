FROM ubuntu:trusty

#install memcached
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y memcached

EXPOSE 11211

CMD ["memcached"]
