FROM xavierdutreilh/node-gettext:8.4.0  
WORKDIR /app  
  
ADD .ssh /root/.ssh  
  
RUN apt-get update  
RUN apt-get -y install imagemagick  
RUN rm -rf /var/lib/apt/lists/*  
  
VOLUME /tmp/ssh-agent  
  
ENV SSH_AUTH_SOCK=/tmp/ssh-agent  

