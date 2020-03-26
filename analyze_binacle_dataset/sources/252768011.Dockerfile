FROM adambrown/java:jdk8_1.0.0  
  
ENV \  
JAVA_OPTS='-DServicePort=${SERVICE_PORT} -DHazelcastPort=${HAZELCAST_PORT}' \  
APPNAME=vertx3-info-server  
  
ADD . /var/tmp/include  
  
RUN \  
cd /var/tmp/include \  
&& ./gradlew build installDist \  
&& mv /var/tmp/include/build/install/${APPNAME} /opt/install \  
&& mv /opt/install/bin/${APPNAME} /opt/install/bin/run \  
&& rm -rf /var/tmp/include \  
&& rm -rf /root/.gradle  
  
USER root  
WORKDIR /opt/install  
  
ENTRYPOINT ["bash", "-ex", "/opt/install/bin/run"]  

