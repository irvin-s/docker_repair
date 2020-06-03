# Postgresql
#
# VERSION               0.3

FROM allisson/docker-ubuntu:latest
MAINTAINER Allisson Azevedo <allisson@gmail.com>

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# install packages
RUN apt-get update
RUN apt-get install -y openssh-server postgresql supervisor

# make /var/run/sshd
RUN mkdir /var/run/sshd

# copy supervisor conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# setup postgresql
ADD set-psql-password.sh /tmp/set-psql-password.sh
RUN /bin/sh /tmp/set-psql-password.sh
RUN sed -i "/^#listen_addresses/i listen_addresses='*'" /etc/postgresql/9.1/main/postgresql.conf
RUN sed -i "/^# DO NOT DISABLE\!/i # Allow access from any IP address" /etc/postgresql/9.1/main/pg_hba.conf
RUN sed -i "/^# DO NOT DISABLE\!/i host all all 0.0.0.0/0 md5\n\n\n" /etc/postgresql/9.1/main/pg_hba.conf

# set root password
RUN echo "root:root" | chpasswd

# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# expose postgresql port
EXPOSE 22 5432

# volumes
VOLUME ["/var/lib/postgresql/9.1/main"]

# start supervisor
CMD ["/usr/bin/supervisord"]
