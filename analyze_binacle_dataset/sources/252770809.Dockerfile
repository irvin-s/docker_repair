FROM ubuntu:trusty  
  
ENV SHA=52a3b9b0e3c134fda6f9c2d8a9d489dd993d213e  
  
RUN \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get install -y wget cmake build-essential zlib1g-dev  
  
RUN \  
wget https://github.com/h2o/h2o/archive/${SHA}.tar.gz && \  
tar -xzvf ${SHA}.tar.gz && \  
cd h2o-${SHA} && \  
cmake -DWITH_BUNDLED_SSL=on . && \  
make && \  
make install  
  
ADD rp.conf /etc/h2o/rp.conf  
ADD server.crt /etc/h2o/server.crt  
ADD server.key /etc/h2o/server.key  
  
EXPOSE 80 443  
CMD ["h2o", "-c", "/etc/h2o/rp.conf"]  

