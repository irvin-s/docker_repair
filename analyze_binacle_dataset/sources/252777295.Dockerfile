FROM maven:3.3.3-jdk-7-onbuild  
  
ENV HOST 0.0.0.0  
ENV PORT 8080  
  
EXPOSE $PORT  
RUN ["mvn", "package"]  
RUN ["mvn", "jetty:start"]  
cmd mvn -Djetty.host=${HOST} -Djetty.port=${PORT} -e jetty:run  

