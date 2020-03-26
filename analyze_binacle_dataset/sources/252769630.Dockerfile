FROM ubuntu  
RUN apt-get update  
RUN apt-get install -y git-core maven openjdk-8-jdk  
RUN mkdir app  
ADD /target/jetty-helloworld-webapp-1.0.war app/app.war  
ADD /target/dependency/jetty-runner.jar app/runner.jar  
EXPOSE 8080  
RUN mkdir /data  
WORKDIR app  
ENTRYPOINT java -jar runner.jar app.war  

