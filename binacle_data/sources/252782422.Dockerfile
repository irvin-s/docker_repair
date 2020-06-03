FROM base:ubuntu-12.10  
RUN apt-get update  
RUN apt-get install -y thrift-compiler  
ENTRYPOINT ["/usr/bin/thrift"]

