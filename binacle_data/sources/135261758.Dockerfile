FROM        ubuntu
RUN         apt-get update && apt-get install -y software-properties-common python-software-properties
RUN         /usr/bin/add-apt-repository ppa:chris-lea/redis-server
RUN         apt-get update
RUN         apt-get -y --force-yes install redis-server
ADD	    redis-server.sh /usr/bin/
ENTRYPOINT  ["/usr/bin/redis-server.sh"]
