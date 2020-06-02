# Google Kubernetes  
FROM centos:latest  
  
ADD ./src /  
  
RUN chmod +x /usr/local/sbin/start.sh  
  
VOLUME ["/target"]  
  
ENTRYPOINT ["/usr/local/sbin/start.sh"]  

