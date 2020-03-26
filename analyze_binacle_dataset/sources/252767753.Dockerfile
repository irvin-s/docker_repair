FROM ubuntu:trusty  
  
RUN apt-get update && apt-get -y install \  
git automake autoconf libtool make gcc pkg-config \  
libmysqlclient-dev mysql-client-5.6  
RUN git clone https://github.com/akopytov/sysbench.git && \  
cd sysbench && ./autogen.sh && \  
./configure && \  
make -j8  
RUN ln -s /sysbench/src/sysbench /usr/bin/sysbench  
COPY entrypoint.sh /entrypoint.sh  
COPY run.sh /run.sh  
ENTRYPOINT ["/entrypoint.sh"]  

