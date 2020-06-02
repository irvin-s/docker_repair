FROM ubuntu:trusty  
MAINTAINER Andre Dieb Martins <andre.dieb@gmail.com>  
  
RUN apt-get update -q && \  
apt-get install -qy ruby2.0 ruby2.0-dev && \  
gem2.0 install bundler && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Speed up bundle install  
RUN rm -rf /root/.gemrc && \  
echo "gem: --no-ri --no-rdoc" >> /root/.gemrc && \  
echo "install: --no-rdoc --no-ri" >> /root/.gemrc  
  
RUN mkdir -p /gemstrap /gemstrap/lib/gemstrap  
WORKDIR /gemstrap  
  
ADD Gemfile gemstrap.gemspec /gemstrap/  
ADD lib/gemstrap/version.rb /gemstrap/lib/gemstrap/  
RUN bundle install --without development  
  
ADD . /gemstrap  
  
EXPOSE 8080  
VOLUME ["/build"]  
WORKDIR /build  
  
ENTRYPOINT ["ruby2.0", "/gemstrap/bin/gemstrap"]  

