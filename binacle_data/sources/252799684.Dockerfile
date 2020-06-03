FROM ubuntu:trusty  
MAINTAINER Andre Dieb Martins <andre.dieb@gmail.com>  
  
RUN apt-get update -q && \  
apt-get install -qy ruby2.0 ruby2.0-dev build-essential && \  
gem2.0 install bundler && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Speed up bundle install  
RUN rm -rf /root/.gemrc && \  
echo "gem: --no-ri --no-rdoc" >> /root/.gemrc && \  
echo "install: --no-rdoc --no-ri" >> /root/.gemrc  
  
RUN mkdir -p /fnd /fnd/lib/fnd  
WORKDIR /fnd  
  
ADD Gemfile fnd.gemspec /fnd/  
ADD lib/fnd/version.rb /fnd/lib/fnd/  
RUN bundle install --without development  
  
ADD . /fnd  
  
EXPOSE 8080  
ENV RACK_ENV production  
  
CMD ["ruby2.0", "./bin/fnd"]  

