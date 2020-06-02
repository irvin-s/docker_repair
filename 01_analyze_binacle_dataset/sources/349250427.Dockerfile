#name of container: docker-octoprint
#versison of container: 0.4.1
FROM quantumobject/docker-baseimage:18.04
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN apt-get update && apt-get install -y -q python-pip python-dev git \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*

##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

##Adding Deamons to containers
# to add octoprint deamon to runit
RUN mkdir -p /etc/service/octoprint /var/log/octoprint ; sync
COPY octoprint.sh /etc/service/octoprint/run
RUN chmod +x /etc/service/octoprint/run \
    && cp /var/log/cron/config /var/log/octoprint/ \
    && chown -R www-data /var/log/octoprint

#pre-config scritp for different service that need to be run when container image is create 
#maybe include additional software that need to be installed ... with some service running ... like example mysqld
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf; sync \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 5000

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
