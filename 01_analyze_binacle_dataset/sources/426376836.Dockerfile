#ifndef DOCKERFILE_SSH
#define DOCKERFILE_SSH

#include "Dockerfile.supervisord"

RUN apt-get install -y ssh
RUN mkdir /var/run/sshd

RUN /bin/echo -e "[program:sshd] \ncommand=/usr/sbin/sshd -D \n" > /etc/supervisor/conf.d/sshd.conf

EXPOSE 22

#endif // DOCKERFILE_SSH