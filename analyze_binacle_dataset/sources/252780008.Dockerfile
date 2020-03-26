FROM node:6  
MAINTAINER xun "me@xun.my"  
# Installing graphicsmagick  
RUN apt-get update  
RUN apt-get install -y --no-install-recommends \  
graphicsmagick \  
&& rm -rf /var/lib/apt/lists/*  
  
CMD ["gm", "-version"]  
  
# docker build -t axnux/gm-node:latest . #  

