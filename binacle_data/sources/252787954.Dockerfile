FROM jpetazzo/dind  
  
# Let's start with some basic stuff.  
RUN apt-get update -qq \  
&& apt-get install -qqy \  
curl \  
git \  
openssh-server \  
supervisor \  
&& apt-get autoclean \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& mkdir -p /var/log/supervisor /var/run/sshd  
  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
RUN touch /root/.firstrun  
  
COPY ./start /start  
RUN chmod +x /start  
  
EXPOSE 22  
EXPOSE 80  
EXPOSE 443  
# Define additional metadata for our image.  
VOLUME [ "/var/lib/docker", "/var/lib/dokku", "/home/dokku" ]  
  
WORKDIR /home/dokku  
  
CMD ["/start"]

