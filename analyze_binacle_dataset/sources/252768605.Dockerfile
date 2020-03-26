FROM debian:wheezy  
MAINTAINER anarcher, anarcher@gmail.com  
ENV HOME /root  
  
RUN apt-get update && apt-get install -y \  
ruby1.9.3 \  
rubygems \  
gnupg \  
gnupg-agent \  
dpkg-sig \  
git \  
libxml2 \  
libxml2-dev \  
libxslt-dev  
  
RUN gem install bundler  
  
WORKDIR /deb  
RUN git clone https://github.com/anarcher/deb-s3.git  
  
WORKDIR /deb/deb-s3  
RUN git checkout a0228cc3a075d48eda0af8d4e97967a859d629ae && bundle install  
  
ENTRYPOINT ["/deb/deb-s3/bin/deb-s3"]  
CMD ["help"]  

