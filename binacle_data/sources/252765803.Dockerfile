FROM java:latest  
MAINTAINER 3apag  
  
# Setup the environment:  
ENV ACTIVATOR_VERSION 1.3.7  
ENV DEBIAN_FRONTEND noninteractive  
  
# Add project source files  
ADD app /opt/app  
ADD test /opt/test  
ADD conf /opt/conf  
ADD public /opt/public  
ADD build.sbt /opt/  
ADD project/plugins.sbt /opt/project/  
ADD project/build.properties /opt/project/  
ADD activator /opt/activator  
ADD activator-launch-$ACTIVATOR_VERSION.jar /opt/  
  
# Build and test the play app - if tests fail, no image will be created  
RUN cd /opt; ./activator test stage  
  
# Build was successful - configure the image:  
WORKDIR /opt  
RUN ["chown", "-R", "daemon:daemon", "."]  
RUN mkdir /opt/logs  
VOLUME ["/opt/logs"]  
USER daemon  
ENTRYPOINT ["target/universal/stage/bin/3ap-status-board"]  
EXPOSE 9000  

