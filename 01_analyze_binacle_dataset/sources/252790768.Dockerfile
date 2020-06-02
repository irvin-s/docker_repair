FROM debian:jessie  
  
MAINTAINER "Jay Gorrell" <artsemis@gmail.com>  
  
ENV REFRESHED_AT 2014-11-30  
  
RUN apt-get update -y && \  
apt-get install python-dev python-pip python-lxml libmysqlclient-dev -y  
  
RUN pip install service_identity scrapy MySQL-python SQLAlchemy scrapyd  
  
RUN mkdir -p /var/lib/scrapyd/projects  
WORKDIR /var/lib/scrapyd/projects  
  
EXPOSE 6800  
  
ENTRYPOINT ["scrapyd"]  

