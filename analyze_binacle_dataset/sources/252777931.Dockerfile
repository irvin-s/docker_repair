FROM debian:jessie  
MAINTAINER Apiary <sre@apiary.io>  
  
ENV REFRESHED_AT 2015-11-25  
RUN apt-get update && \  
apt-get install -y jq curl dnsutils  
  
RUN useradd -G sudo -m spf-user  
  
WORKDIR /home/spf-user  
  
COPY . /home/spf-user/spf-tools  
  
USER spf-user  
CMD ["./spf-tools/docker/run.sh"]  

