FROM ubuntu  
MAINTAINER Attentive Team "dev-team@attentive.us"  
RUN apt-get -qq update  
RUN apt-get install -y \  
python-dev \  
python-setuptools \  
python-pip \  
python-imaging \  
python-pil \  
python-django \  
git-core \  
curl \  
wget \  
libpq-dev \  
python-psycopg2 \  
libjpeg-dev \  
libfreetype6-dev \  
zlib1g-dev \  
libxml2-dev \  
libxslt1-dev \  
libffi-dev \  
yajl-tools \  
libmemcached-dev \  
liblapack-dev \  
libblas-dev \  
gfortran \  
python-numpy \  
libicu-dev  
  
  
COPY requirements.txt requirements.txt  
RUN pip install -r requirements.txt  

