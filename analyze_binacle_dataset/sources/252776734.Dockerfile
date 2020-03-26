FROM google/golang  
  
MAINTAINER chris@cbeer.info  
  
WORKDIR /opt  
RUN git clone https://github.com/google/cayley.git  
  
WORKDIR /opt/cayley  
RUN make deps && make  
RUN mkdir /mnt/cayley-data  
  
VOLUME /mnt/cayley-data  
EXPOSE 64210  
ENTRYPOINT ["/opt/cayley/cayley"]  
CMD ["http", "--db=leveldb", "--dbpath=/mnt/cayley-data"]  

