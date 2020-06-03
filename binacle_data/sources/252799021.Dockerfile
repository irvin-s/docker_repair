#  
# Image for Open DevOps Pipeline  
#  
#VERSION : 0.1  
FROM docker.io/capitalone/hygieia-sonar-codequality-collector  
  
#Maintainer  
MAINTAINER Open DevOps Team <open.devops@gmail.com>  
  
#Environment variables  
ENV SPRING_DATA_MONGODB_HOST=localhost  
ENV SPRING_DATA_MONGODB_PORT=27017  

