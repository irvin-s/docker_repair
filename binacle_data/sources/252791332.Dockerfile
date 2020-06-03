FROM library/postgres:9.4  
MAINTAINER Jiri  
  
ENV MULTICORN_VERSION 1.0.4  
ENV PG_VERSION 9.4  
  
RUN apt-get update -qq && \  
apt-get upgrade -y && \  
apt-get install -y \  
build-essential \  
libxslt1-dev \  
libxml2-dev \  
python-dev \  
python-pip \  
postgresql-server-dev-$PG_VERSION && \  
apt-get clean && \  
pip install pgxnclient && \  
pgxn install multicorn==$MULTICORN_VERSION && \  
pip install lxml  
  
  
ADD init.sql /docker-entrypoint-initdb.d/  

