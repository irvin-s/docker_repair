FROM debian:jessie  
MAINTAINER Pieter Nicolai  
  
RUN apt-get update && apt-get install -y beanstalkd  
RUN apt-get autoremove && apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
RUN mkdir /data  
  
VOLUME ["/data"]  
EXPOSE 11300  
CMD ["-f", "60000", "-b", "/data"]  
ENTRYPOINT ["/usr/bin/beanstalkd"]

