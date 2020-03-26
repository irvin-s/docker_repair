FROM jenkins/jenkins:lts  
  
# installs jenkins  
USER root  
RUN apt-get update && apt-get install -y cmake g++ libgtk2.0-dev  

