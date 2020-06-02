# HEADER  
FROM gliderlabs/alpine  
MAINTAINER abaranov@linux.com  
  
# Trigger rebuild  
ENV UPDATED_AT 2015-03-19  
# Install Quagga  
RUN apk-install quagga \  
supervisor  
  
# Supervisord  
ADD supervisord.conf /etc/supervisord.conf  
  
# Configuration files  
VOLUME /etc/quagga  
  
# Expose ports  
EXPOSE 179 2601 2605  
# Command  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]  

