FROM ubuntu:14.04  
MAINTAINER Charo Wang (taken from Kimmo Huoman <kipenroskaposti@gmail.com>)  
  
RUN apt-get update && apt-get install -y \  
gcc \  
python-dev \  
python-pip  
  
# copy Upstart script to init  
CMD ["cp", "/app/mem_log.conf", "/etc/init/"]  
  
# Add app  
ADD /app /app  
# Install the app requirements  
RUN pip install -r /app/requirements.txt  
  
# Create configuration for supervisord  
RUN echo_supervisord_conf > /usr/local/etc/supervisord.conf && \  
echo "[include]" >> /usr/local/etc/supervisord.conf && \  
echo "files = /app/supervisor/*.conf" >> /usr/local/etc/supervisord.conf  
  
# Finally, start our app  
CMD ["bash", "/app/start.sh"]  

