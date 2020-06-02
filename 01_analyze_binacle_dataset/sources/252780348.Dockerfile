FROM gcr.io/google_appengine/nodejs  
  
ENV USER root  
RUN apt-get update && \  
apt-get install -y libssl-dev build-essential  
  
RUN install_node v6.3.1  

