FROM ubuntu:trusty  
MAINTAINER Todd Willey <todd.willey@cirrusmio.com>  
  
EXPOSE 3000  
ENV BUNDLE_PATH=/bundle  
ENV BUNDLE_WORKERS=4  
VOLUME /bundle  
  
WORKDIR /usr/src/app  
  
RUN apt-get update && \  
apt-get install --yes software-properties-common && \  
add-apt-repository --yes ppa:brightbox/ruby-ng && \  
apt-get update && \  
apt-get install --yes ruby2.1 ruby2.1-dev libruby2.1 \  
build-essential libpq-dev libcurl4-openssl-dev \  
nodejs libqt4-dev libsqlite3-dev default-jre \  
libmysqlclient-dev libxml2-dev libxslt-dev \  
imagemagick && \  
gem install --no-rdoc --no-ri bundler foreman  
  
COPY . /usr/src/app  
  
ENTRYPOINT ["./entrypoint.sh"]  

