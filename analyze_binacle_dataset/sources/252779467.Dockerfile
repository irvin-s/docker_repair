  
FROM ubuntu:15.04  
MAINTAINER Conor Heine <conor.heine@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV AIRFLOW_HOME /airflow  
  
RUN apt-get --yes update  
RUN apt-get --yes install \  
python2.7 \  
python-dev \  
python-setuptools \  
python-pip \  
python-crypto \  
python-psycopg2  
RUN apt-get --yes install libssl-dev libffi-dev  
RUN pip install cryptography celery  
RUN mkdir /airflow && pip install airflow  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
VOLUME /airflow  
WORKDIR /airflow  
EXPOSE 9090  
CMD airflow initdb && airflow webserver -p 9090  
  

