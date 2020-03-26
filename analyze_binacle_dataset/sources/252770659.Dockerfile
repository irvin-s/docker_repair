FROM ubuntu:14.04  
MAINTAINER Aexea Carpentry  
  
RUN apt-get update && apt-get install -y nodejs nodejs-legacy npm  
  
RUN npm install -g github-changes  
  
CMD ["github-changes", "-o aexeagmbh -r django_saltstack --no-merges"]  

