FROM dpredkel/ubuntu-java8  
  
ENV JAVA_APP_DIR=/deployments \  
JAVA_MAJOR_VERSION=8  
RUN mkdir -p /deployments  
  
COPY run-java.sh /deployments/  
RUN chmod 755 /deployments/run-java.sh  
  
CMD ["/deployments/run-java.sh"]  

