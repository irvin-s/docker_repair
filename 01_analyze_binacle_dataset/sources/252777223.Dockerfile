FROM ceroic/kubectl:latest  
MAINTAINER Ceroic <ops@ceroic.com>  
  
# Create directories for loading templates and output  
RUN mkdir -p /var/kubectl-watch/templates  
RUN mkdir -p /var/kubectl-watch/output  
  
# Add our script  
COPY kubectl-watch.sh /usr/bin/kubectl-watch  
RUN chmod +x /usr/bin/kubectl-watch  
  
CMD ["kubectl-watch"]  

