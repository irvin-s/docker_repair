FROM maven:3.5.2-jdk-8-alpine  
ADD . /web  
WORKDIR /web  
RUN mvn package -Dmaven.test.skip=true  
RUN mkdir /app && cp target/*.jar /app  
WORKDIR /app  
RUN rm -rf /web  
EXPOSE 8000  
CMD java -jar -Dcustom.server.url=$CONFIG_SERVER_URL *.jar  

