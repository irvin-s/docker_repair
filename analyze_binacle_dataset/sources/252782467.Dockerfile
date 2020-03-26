FROM maven:alpine  
  
COPY . /usr/src/app  
RUN cd /usr/src/app &&\  
mvn package &&\  
cp target/http-echo-1.0-SNAPSHOT.jar /usr/src/http-echo.jar &&\  
rm -rf /root/.m2/repository /usr/src/app  
  
CMD ["java", "-jar", "/usr/src/http-echo.jar"]  

