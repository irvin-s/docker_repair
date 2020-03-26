FROM debian:stable-slim  
  
ARG CA_CERTIFICATES_VERSION=20161130+nmu1  
  
RUN apt-get update && apt-get install -y \  
ca-certificates=${CA_CERTIFICATES_VERSION} \  
;  

