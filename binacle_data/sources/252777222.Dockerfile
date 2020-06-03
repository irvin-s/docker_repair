FROM ceroic/docker-slave:1.11.2  
MAINTAINER Ceroic <ops@ceroic.com>  
  
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1  
ENV PATH /opt/google-cloud-sdk/bin:$PATH  
  
# Install Google Cloud SDK and kubectl  
RUN curl https://sdk.cloud.google.com | bash && mv google-cloud-sdk /opt  
RUN gcloud components install kubectl  
  

