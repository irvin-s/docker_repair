FROM google/cloud-sdk:alpine  
  
# Library needed to run docker  
RUN apk add --no-cache libltdl  
  
# Install kubectl  
RUN gcloud components install kubectl -q  
  
WORKDIR /root

