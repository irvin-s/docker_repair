FROM ubuntu:latest  
MAINTAINER Boggart "github.com/Boggart"  
# We use a bootstrap script to avoid having temporary cache files and build  
# dependencies being committed and included into the docker image.  
ADD bootstrap.sh /tmp/  
RUN chmod +x /tmp/bootstrap.sh && /tmp/bootstrap.sh  
  
RUN useradd znc  
ADD start-znc /usr/local/bin/  
ADD znc.conf.default /src/  
RUN chmod 644 /src/znc.conf.default  
  
EXPOSE 6667  
ENTRYPOINT ["/usr/local/bin/start-znc"]  
CMD [""]  

