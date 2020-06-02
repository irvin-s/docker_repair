FROM        ubuntu
RUN         apt-get update
RUN         apt-get -y install beanstalkd
EXPOSE      11300
ENTRYPOINT  ["/usr/bin/beanstalkd"]
