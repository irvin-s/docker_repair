FROM ubuntu:trusty  
  
COPY requirements.txt /tmp/requirements.txt  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update -y && \  
apt-get install -y python-pip \  
python-dev \  
libncurses5-dev \  
libpq-dev \  
python-psycopg2 \  
libxml2-dev \  
libxslt-dev \  
libffi-dev \  
qpdf \  
poppler-utils &&\  
pip install -r /tmp/requirements.txt && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
ln -snf /bin/bash /bin/sh \  

