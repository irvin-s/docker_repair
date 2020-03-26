FROM mdillon/postgis:9.5  
MAINTAINER Alex Kerney <abk@mac.com>  
  
RUN apt-get update && apt-get install -y \  
python3 \  
python3-dev \  
python3-pip \  
libsnappy-dev \  
postgresql-server-dev-9.5 \  
libffi-dev  
  
RUN pip3 install \  
boto \  
httplib2 \  
google-api-python-client \  
azure  
  
ADD https://github.com/ohmu/pghoard/archive/1.4.0.tar.gz /opt/pghoard.tar.gz  
RUN tar xzf /opt/pghoard.tar.gz  
RUN python3 /pghoard-1.4.0/setup.py bdist_egg  
RUN easy_install3 /pghoard-1.4.0/dist/pghoard-1.4.0-py3.4.egg  
  
RUN mkdir /backups  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
COPY ./initdb-pghoard.sh /docker-entrypoint-initdb.d/initdb-pghoard.sh  
  
EXPOSE 5432  
CMD ["postgres"]  

