#
# Dockerfile to build simple M2M GUI demo
#
FROM ubuntu:14.04
MAINTAINER Simon Chatterjee <sichatte@cisco.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python-twisted-conch python-twisted-web ruby-sass openssh-client

EXPOSE 8080
CMD /src/run
