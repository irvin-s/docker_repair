#JENKINS  
FROM jenkins  
USER root  
  
#ADD BASELINE jenkins_home FOLDER  
#ADD ./jenkins_home /var/jenkins_home  
RUN apt-get update  
RUN apt-get install -y apt-utils  
RUN apt-get install -y sudo  
RUN apt-get install -y curl  
RUN rm -rf /var/lib/apt/lists/*  
  
#INSTALL NODE  
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -  
RUN apt-get install -y nodejs  

