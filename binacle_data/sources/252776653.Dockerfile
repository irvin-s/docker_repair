FROM anapsix/alpine-java:jdk8  
MAINTAINER Catz Sy <sy.catz@gmail.com>  
  
RUN apk --update add wget ca-certificates  
RUN apk add --update --no-cache libstdc++  
  
# Install Gradle  
RUN wget https://services.gradle.org/distributions/gradle-2.14-bin.zip  
RUN unzip gradle-2.14-bin.zip  
RUN mv gradle-2.14 /opt/  
RUN rm gradle-2.14-bin.zip  
  
#Set environment variables  
ENV GRADLE_HOME /opt/gradle-2.14  
ENV PATH $PATH:$GRADLE_HOME/bin  
  
  
#Create app directory  
RUN mkdir -p /usr/app  
WORKDIR /usr/app  
  
# Prepare by downloading dependencies  
ADD build.gradle build.gradle  
ADD settings.gradle settings.gradle  
  
# Adding source, compile and package into a fat jar  
ADD src /usr/app/src  
  
RUN ["gradle", "clean"]  
RUN ["gradle", "build"]  
RUN ["gradle", "shadowJar"]  
  
EXPOSE 5555  
ENTRYPOINT ["java", "-jar", "build/libs/hello-server.jar"]

