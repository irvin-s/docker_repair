# VERSION 1.0  
# DOCKER-VERSION 1.2.0  
# AUTHOR: Richard Lee <lifuzu@gmail.com>  
# DESCRIPTION: Devbase-rvm Image Container  
FROM dockerbase/devbase-rvm  
  
ENV LC_ALL C  
ENV DEBIAN_FRONTEND noninteractive  
  
USER devbase  
  
# Set environment variables.  
ENV HOME /home/devbase  
  
# Define working directory.  
WORKDIR /home/devbase  
  
# Install Unicorn  
RUN /bin/bash -lc "gem install unicorn"  
  
# Define default command.  
CMD ["bash"]  

