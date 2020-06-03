FROM ubuntu:precise
MAINTAINER Martin Gondermann magicmonty@pagansoft.de

# Create data directories
RUN mkdir -p /data/mysql /data/www

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y -q install curl unzip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN curl -G -o /data/joomla.zip http://joomlacode.org/gf/download/frsrelease/19239/158104/Joomla_3.2.3-Stable-Full_Package.zip && \
	unzip /data/joomla.zip -d /data/www && \
	rm /data/joomla.zip

# Create /data volume
VOLUME ["/data"]

CMD /bin/sh
