FROM debian:stretch  
  
RUN apt-get update && apt-get install -y \  
git \  
inkscape  
  
# Installing fonts  
COPY lib/install-google-fonts /tmp/  
RUN /tmp/install-google-fonts  
  
# Cleaning  
RUN apt-get clean  

