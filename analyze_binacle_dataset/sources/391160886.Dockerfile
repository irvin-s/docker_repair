#name of container: docker-transmission
#versison of container: 0.5.8
FROM quantumobject/docker-baseimage:18.04
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

# Set correct environment variables.
ENV USER_T guest
ENV PASSWD_T guest

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN apt-get update && apt-get install -y -q --no-install-recommends build-essential automake \
                    autoconf libtool pkg-config intltool libcurl4-openssl-dev \
                    libglib2.0-dev libevent-dev xz-utils libssl-dev \
                    libminiupnpc-dev libminiupnpc10 libappindicator-dev \
                    && wget https://github.com/transmission/transmission/archive/2.94.tar.gz \
                    && tar xvf 2.94.tar.gz \
                    && rm 2.94.tar.gz \
                    && cd transmission-2.94 \
                    && ./autogen.sh -q --enable-daemon --with-inotify --enable-nls && make -s \
                    && make install \
                    && cd .. \
                    && rm -R /transmission-2.94 \
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
RUN mkdir /etc/service/transmission /var/log/transmission ; sync
COPY transmission.sh /etc/service/transmission/run
RUN chmod +x /etc/service/transmission/run \
    && cp /var/log/cron/config /var/log/transmission/ 


##scritp that can be running from the outside using docker-bash tool ...
## for example to create backup for database with convitation of VOLUME   dockers-bash container_ID backup_mysql
COPY backup.sh /sbin/backup
RUN chmod +x /sbin/backup
VOLUME /var/backups

#add files and script that need to be use for this container
#include conf file relate to service/daemon 
#additionsl tools to be use internally 
COPY settings.json /var/lib/transmission-daemon/info/settings.json

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 9091

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
