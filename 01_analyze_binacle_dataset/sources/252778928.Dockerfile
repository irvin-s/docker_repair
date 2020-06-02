FROM ubuntu:latest  
  
# Decompress the tarball in the container  
ADD qdb-*-linux-64bit-server.tar.gz /usr/  
  
# Add the wrapper script  
ADD qdbd-docker-wrapper.sh /usr/bin/  
  
# Define mountable directory  
VOLUME ["/var/lib/qdb/db"]  
  
# Define working directory  
WORKDIR /var/lib/qdb  
  
# Always launch qdb process  
ENTRYPOINT ["/usr/bin/qdbd-docker-wrapper.sh"]  
  
# Expose the port qdbd is listening at  
EXPOSE 2836  

