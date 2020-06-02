FROM jenkins/jenkins:lts  
  
COPY config.xml /usr/share/jenkins/ref/jobs/gitclone/config.xml  

