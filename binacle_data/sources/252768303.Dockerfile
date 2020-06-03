FROM java:8u111-jdk  
  
ENV SERVICE_JAR_URL ""  
ENV SERVICE_JAVA_ARGUMENTS ""  
ADD startup.sh /usr/bin/startup.sh  
  
CMD ["/usr/bin/startup.sh"]  

