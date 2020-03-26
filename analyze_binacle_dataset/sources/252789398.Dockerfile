FROM x11docker/xfce  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Docker from Docker Inc. repositories.  
RUN curl -sSL https://get.docker.com/ | sh  
  
# Install the magic wrapper.  
ADD ./wrapdocker /usr/local/bin/wrapdocker  
RUN chmod +x /usr/local/bin/wrapdocker  
  
# Define additional metadata for our image.  
VOLUME /var/lib/docker  
  
CMD ["wrapdocker"]  

