FROM java:7u91-alpine  
  
COPY apache-tomcat-7.0.57 /  
RUN rm bin/*.bat  
  
EXPOSE 8080  
CMD ["catalina.sh", "run"]  

