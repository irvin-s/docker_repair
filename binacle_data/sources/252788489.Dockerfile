FROM crux/python:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
ENTRYPOINT ["/usr/bin/devpi-server"]  
CMD ["--host", "0.0.0.0", "--serverdir", "/var/lib/devpi"]  
  
VOLUME /var/lib/devpi  
  
EXPOSE 3141  
RUN pip install devpi-server  

