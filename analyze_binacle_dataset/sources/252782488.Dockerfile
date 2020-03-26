FROM debian:jessie  
MAINTAINER cl3m3nt  
RUN apt-get update && apt-get -y install \  
curl \  
wget \  
jq \  
&& rm -rf /var/lib/apt/lists/*  
ENV TIMESLEEP 1  
ENV TIMERENOTIFY 60  
COPY bin /kimsufi  
WORKDIR /kimsufi  
CMD ["bash", "run.sh"]  

