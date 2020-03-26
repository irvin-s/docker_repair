FROM        ubuntu
EXPOSE      26379
RUN         apt-get update && apt-get install -y software-properties-common python-software-properties
RUN         /usr/bin/add-apt-repository ppa:chris-lea/redis-server
RUN         apt-get update
RUN         apt-get -y --force-yes install redis-server
RUN         touch /tmp/sentinel.conf
CMD         ["/tmp/sentinel.conf","--sentinel","--port 26379","--loglevel warning"]
ENTRYPOINT  ["/usr/bin/redis-server"]
