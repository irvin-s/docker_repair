FROM debian:wheezy

MAINTAINER Obaid Salikeen <obaidsalikeen@gmail.com>

# Install the software needed to execute Storm
RUN apt-get update; apt-get install -y unzip openjdk-7-jre-headless wget supervisor openssh-server

# Download latest Apache Storm release
RUN apt-get update &&  wget http://people.apache.org/~ptgoetz/apache-storm-0.9.3-rc1/apache-storm-0.9.3-rc1.tar.gz && tar -xzf apache-storm-0.9.3-rc1.tar.gz  -C /opt 

# Set environment variable
ENV STORM_HOME /opt/apache-storm-0.9.3-rc1

# Create storm user and logs directory
RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm

# Link storm command
RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm

ADD storm.yaml $STORM_HOME/conf/storm.yaml

