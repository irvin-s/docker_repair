FROM ubuntu:xenial  
  
# Decompress the tarball in the container  
ADD qdb-*-linux-64bit-web-bridge.tar.gz /usr/  
  
# Add the wrapper script  
ADD qdb-httpd-docker-wrapper.sh /usr/bin/  
  
# Always launch qdb process  
ENTRYPOINT ["/usr/bin/qdb-httpd-docker-wrapper.sh"]  
  
# Expose the port qdb-httpd is listening at  
EXPOSE 8080  

