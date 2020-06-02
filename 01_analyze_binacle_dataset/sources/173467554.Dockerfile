FROM busybox
MAINTAINER hadrien.mary@gmail.com

# Add sysadmin user
RUN echo 'sysadmin:x:1000:1000::/data:/bin/sh' >> /etc/passwd
RUN echo 'sysadmin:x:1000:' >> /etc/group

RUN mkdir /data
RUN chown sysadmin.sysadmin /data
RUN chmod 777 /data
RUN touch /data/init_volume

WORKDIR /data
VOLUME /data
