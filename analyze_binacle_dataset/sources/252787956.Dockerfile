FROM ubuntu:14.04  
MAINTAINER Craig Gardener <craiggardener.me@gmail.com>  
  
# This Dockerfile is used to build the "mailcatcher" Docker image.  
# Install Mailcatcher gem  
RUN apt-get update \  
&& apt-get install -y ruby ruby-dev build-essential sqlite3 libsqlite3-dev \  
&& gem install mailcatcher --no-ri --no-rdoc \  
&& apt-get remove --purge -y build-essential ruby-dev libsqlite3-dev \  
&& apt-get autoclean \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Expose mailserver port  
EXPOSE 1025  
# Expose webserver port  
EXPOSE 1080  
  
CMD ["mailcatcher", "-f", "--ip=0.0.0.0"]  

