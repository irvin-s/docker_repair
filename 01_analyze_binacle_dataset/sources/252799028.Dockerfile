FROM devoto13/gunicorn  
  
MAINTAINER Yaroslav Admin <devoto13@gmail.com>  
  
# Install postgres client  
RUN sudo apt-get install -y libpq-dev  
  
# Start Script  
ADD startup /usr/local/bin/startup  
RUN chmod +x /usr/local/bin/startup  
  
CMD ["/usr/local/bin/startup"]  
  
# Volumes  
VOLUME ["/root/app/media"]  

