FROM ubuntu:trusty  
MAINTAINER Andre Dieb Martins <andre.dieb@gmail.com>  
  
RUN apt-get update -q && \  
apt-get install -qy nodejs ruby2.0 ruby2.0-dev build-essential && \  
apt-get install -qy libpq-dev && \  
apt-get install -qy postgresql-client --no-install-recommends && \  
gem2.0 install bundler && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Speed up bundle install  
RUN rm -rf /root/.gemrc && \  
echo "gem: --no-ri --no-rdoc" >> /root/.gemrc && \  
echo "install: --no-rdoc --no-ri" >> /root/.gemrc  
  
RUN mkdir /packager /tmp/build  
ADD build.sh /packager/  
WORKDIR /tmp/build  
  
VOLUME ["/source", "/build"]  
  
CMD ["/packager/build.sh"]

