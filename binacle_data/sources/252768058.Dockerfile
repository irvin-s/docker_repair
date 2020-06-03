FROM maven AS build  
  
WORKDIR /build  
ADD pom.xml /build  
  
RUN mvn dependency:go-offline dependency:resolve-plugins  
  
ADD src /build/src  
  
RUN mvn package  
  
FROM openjdk:8-jdk  
  
WORKDIR /app  
COPY --from=build /build/target/memoryhog.jar /app  
  
ENV JMX_HOSTNAME=localhost  
ENV MAX_RAM_FRACTION=1  
  
CMD java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom \  
-XX:+UnlockExperimentalVMOptions \  
-XX:+UseCGroupMemoryLimitForHeap \  
-XshowSettings:vm -XX:MaxRAMFraction=$MAX_RAM_FRACTION \  
-Dcom.sun.management.jmxremote=true \  
-Dcom.sun.management.jmxremote.local.only=false \  
-Dcom.sun.management.jmxremote.authenticate=false \  
-Dcom.sun.management.jmxremote.ssl=false \  
-Djava.rmi.server.hostname=$JMX_HOSTNAME \  
-Dcom.sun.management.jmxremote.port=9999 \  
-Dcom.sun.management.jmxremote.rmi.port=9999 \  
-jar /app/memoryhog.jar  

