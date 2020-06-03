FROM benizar/postgres-ext:9.6  
MAINTAINER Benito Zaragozí <benizar@gmail.com>  
  
  
######################  
# Versions and sources  
######################  
#from https://github.com/benizar/  
ENV SOURCE https://github.com/benizar/  
ENV SAKILA https://github.com/benizar/pg_sakila_db.git  
  
  
################  
# Install pg_sakila_db  
################  
WORKDIR /install-ext  
RUN git clone $SAKILA  
WORKDIR /install-ext/pg_sakila_db  
RUN make  
RUN make install  
  
################  
# Install pg_adm  
################  
WORKDIR /install-ext  
  
ADD doc doc/  
ADD sql sql/  
ADD test test/  
ADD makefile makefile  
ADD META.json META.json  
ADD pg_adm.control pg_adm.control  
  
RUN make  
RUN make install  
  
  
WORKDIR /  
RUN rm -rf /install-ext  
  
ADD init-db.sh /docker-entrypoint-initdb.d/init-db.sh  
  
  

