FROM gradle:3.4.1-jdk8-alpine  
LABEL "owner"="dperisro@everis.com"  
USER root  
  
EXPOSE 8080  
RUN mkdir -p /opt/project  
ADD src/ /opt/project/src/  
ADD build.gradle /opt/project/build.gradle  
WORKDIR /opt/project/  
  
RUN gradle clean assemble  
RUN mv build/libs/app.jar /opt/app.jar  
  
RUN rm -rf /opt/gradle /opt/project/  
  
WORKDIR /opt  
RUN sh -c 'touch app.jar'  
ENTRYPOINT exec java ${JAVA_OPTS} -jar app.jar

