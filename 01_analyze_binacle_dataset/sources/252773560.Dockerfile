FROM ubuntu:trusty  
MAINTAINER Aliaksei Kiryanau <aliaksei.kiryanau1@gmail.com>  
  
# Prevent dpkg errors  
ENV TERM=xterm-256color  
  
# Set mirrors to BY  
RUN sed -i "s/http:\/\/archive./http:\/\/by.archive./g" /etc/apt/sources.list  
  
# Install Python runtime  
RUN apt-get update && \  
apt-get install -y \  
-o APT::Install-Recommended=false -o APT::Install-Suggests=false \  
python python-virtualenv libpython2.7 python-mysqldb  
  
# Create virtual environment  
# Upgrade PIP in virtual environment to latest version  
RUN virtualenv /appenv && \  
. /appenv/bin/activate && \  
pip install pip --upgrade  
  
# Add entrypoint script  
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh  
RUN chmod +x /usr/local/bin/entrypoint.sh  
ENTRYPOINT ["entrypoint.sh"]  
  
LABEL application=todobackend

