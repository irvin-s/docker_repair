FROM base
MAINTAINER Cyril Mougel "cyril.mougel@gmail.com"
 
RUN apt-get update
RUN apt-get install -q -y wget
RUN apt-get install -q -y ca-certificates
RUN apt-get install -q -y make
 
## Ruby-install
RUN wget -O ruby-install-0.1.4.tar.gz https://github.com/postmodern/ruby-install/archive/v0.1.4.tar.gz
RUN tar -xzvf ruby-install-0.1.4.tar.gz
 
## install ruby 2.0.0
RUN ruby-install-0.1.4/bin/ruby-install ruby 2.0.0 -i /opt/rubies/ruby-2.0.0
 
ENV PATH /opt/rubies/ruby-2.0.0/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
