FROM maven:alpine  
MAINTAINER mr5 <mr5.simple@gmail.com>  
  
EXPOSE 8888  
COPY . /opt/spring-cloud-config-server/  
WORKDIR /opt/spring-cloud-config-server/  
RUN mvn package  
WORKDIR /  
CMD java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom \  
-jar /opt/spring-cloud-config-server/target/docker-spring-cloud-config-server-*.jar \  
\--server.port=8888 \  
\--spring.config.name=application \  
\--spring.cloud.config.server.git.uri=${SPRING_CONFIG_GIT_URI} \  
\--spring.cloud.config.server.git.username=${SPRING_CONFIG_GIT_USERNAME} \  
\--spring.cloud.config.server.git.password=${SPRING_CONFIG_GIT_PASSWORD}  

