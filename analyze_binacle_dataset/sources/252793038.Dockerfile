FROM mdillon/postgis:9.6  
MAINTAINER Benito Zaragozí <benizar@gmail.com>  
  
# pg_popyramids install  
RUN apt-get update  
RUN apt-get install -y build-essential checkinstall postgresql-server-dev-9.6  
  
# copy and compile pg_popyramids  
COPY /ext/ /pg_popyramids/  
  
RUN cd pg_popyramids &&\  
make &&\  
make install &&\  
cd .. &&\  
rm -Rf pg_popyramids  
  
# clean packages  
#RUN apt-get remove -y build-essential checkinstall postgresql-server-dev-9.6  
RUN mkdir -p /docker-entrypoint-initdb.d  
COPY ./initdb-pg_popyramids.sh /docker-entrypoint-initdb.d/pg_popyramids.sh  

