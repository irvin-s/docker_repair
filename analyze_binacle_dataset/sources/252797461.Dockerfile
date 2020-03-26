from jenkins/jenkins:lts  
  
# install docker  
USER root  
RUN apt-get update && apt-get install -y docker  
  
USER jenkins

