FROM openjdk:jre-alpine  
  
RUN set -ex \  
&& apk update \  
&& apk upgrade \  
&& apk add git  
  
RUN git clone --depth 1 --branch artifacts \  
"https://github.com/allen13/voter-service.git" \  
&& mv voter-service/voter-service-*.jar ./voter-service.jar \  
&& rm -rf voter-service/  
  
ENV SPRING_PROFILE docker-production  
EXPOSE 8099  
CMD java -jar ./voter-service.jar \  
\--spring.profiles.active=$SPRING_PROFILE \  
-Djava.security.egd=file:/dev/./urandom  

