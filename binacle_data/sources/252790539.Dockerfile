FROM lsiobase/alpine.python:3.7  
# Set python to use utf-8 rather than ascii.  
ENV PYTHONIOENCODING="UTF-8"  
# Copy local files.  
COPY etc/ /etc  
  
# The pip installation is broken somehow this fixes it  
RUN curl https://bootstrap.pypa.io/get-pip.py | python  
  
RUN chmod -v +x \  
/etc/cont-init.d/* \  
/etc/services.d/*/run  
  
# Ports and volumes.  
EXPOSE 5050/tcp  
VOLUME /config  

