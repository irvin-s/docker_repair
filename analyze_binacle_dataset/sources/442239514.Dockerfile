#
# Dockerfile that builds container with jackrabbit


# Image: Postgres
#
# VERSION               0.0.1

FROM     ubuntu
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

# make sure the package repository is up to date
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update -y


#
# Install dependencies
#

RUN apt-get install -y openjdk-7-jdk wget


#
# Fetch jackrabbit
#

RUN /usr/bin/wget http://apache.mirrors.spacedump.net/jackrabbit/2.8.0/jackrabbit-standalone-2.8.0.jar



#
# Start jackrabbit
#

EXPOSE 8080

CMD ["/usr/bin/java","-jar jackrabbit-standalone-2.8.0.jar"]
