# Jenkins with AWS Commandline Tools  
#  
# GitHub - http://github.com/dalekurt/docker-jenkins-awscli  
# Docker Hub - http://hub.docker.com/u/dalekurt/docker-jenkins-awscli  
# Twitter - http://www.twitter.com/dalekurt  
FROM dalekurt/jenkins  
MAINTAINER Dale-Kurt Murray "dalekurt.murray@gmail.com"  
RUN apt-get install -y git  
RUN apt-get install -y python-pip python-dev build-essential  
RUN pip install awscli  

