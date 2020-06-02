FROM google/cloud-sdk:170.0.1-alpine  
  
MAINTAINER Tommy Chen <tommy351@gmail.com>  
  
RUN gcloud config set disable_prompts true && \  
gcloud config set container/use_client_certificate true && \  
gcloud components install kubectl  

