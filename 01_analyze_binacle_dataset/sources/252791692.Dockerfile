# Jenkins for Ubuntu 14.04  
#  
# GitHub - http://github.com/dalekurt/docker-jenkins  
# Docker Hub - http://hub.docker.com/u/dalekurt/jenkins  
# Twitter - http://www.twitter.com/dalekurt  
FROM dalekurt/base  
MAINTAINER Dale-Kurt Murray "dalekurt.murray@gmail.com"  
ADD http://mirrors.jenkins-ci.org/war/1.608/jenkins.war /opt/jenkins.war  
RUN chmod 644 /opt/jenkins.war  
ENV JENKINS_HOME /jenkins  
RUN apt-get install -y git  
RUN apt-get install -y python-pip python-dev build-essential  
RUN pip install awscli  
  
ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]  
EXPOSE 8080  
CMD [""]  

