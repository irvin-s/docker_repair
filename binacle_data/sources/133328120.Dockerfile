# This Dockerfile example updates the ssh/apache example at
# <http://docs.docker.com/articles/using_supervisord/> and makes use of minit
# (https://github.com/chazomaticus/minit) instead of supervisord.
#
# Build with:
#     sudo docker build -t minit-example .
#
# Run in the foreground with:
#     sudo docker run -i -t --sig-proxy minit-example
#
#
# Here's what docker images reports for this example, compared to an equivalent
# one running supervisord:
#     REPOSITORY            TAG      ...   VIRTUAL SIZE
#     minit-example         latest   ...   333 MB
#     supervisord-example   latest   ...   357.1 MB
#
# That's 24M smaller (about 7%) without losing anything but supervisord's
# service monitoring.  It's not a huge difference, but it can be significant.


FROM chazomaticus/minit:latest
MAINTAINER examples@docker.io

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y openssh-server apache2
RUN mkdir -p /var/run/sshd

ADD startup /etc/minit/startup
# We don't need anything special on shutdown, since minit already supplies
# anything running with SIGTERM when it's shutting down.

EXPOSE 22 80

# The minit base image has the appropriate ENTRYPOINT, so we're done.
