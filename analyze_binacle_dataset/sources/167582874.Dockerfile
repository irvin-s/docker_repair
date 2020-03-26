FROM        ubuntu:18.04
MAINTAINER  Frank Lemanschik
 
ENV DEBIAN_FRONTEND noninteractive

# Update apt sources
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update the package repository
RUN apt-get -qq update

# Install base system
RUN apt-get install -y varnish vim git

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

# Export environment variables
ENV VARNISH_PORT 80

# Expose port 80
EXPOSE 80

ADD parse /parse
ADD start /start

RUN chmod 0755 /start /parse

CMD ["/start"]
