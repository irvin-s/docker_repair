FROM debian:jessie  
MAINTAINER Christophe Burki, christophe.burki@gmail.com  
  
# Install system requirements  
RUN apt-get update && apt-get install -y \  
curl \  
locales \  
python-imaging \  
python-pip \  
python-setuptools \  
sqlite3  
  
# Configure locales and timezone  
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 fr_CH.UTF-8  
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime  
RUN echo "Europe/Zurich" > /etc/timezone  
  
# Copy media files  
COPY media/burkionline-cloud-logo.png /tmp/burkionline-cloud-logo.png  
  
# Supervisor config  
RUN mkdir /var/log/supervisor  
RUN pip install supervisor  
COPY configs/supervisord.conf /etc/supervisord.conf  
  
# Startup script  
COPY scripts/start.sh /opt/start.sh  
RUN chmod 755 /opt/start.sh  
  
EXPOSE 10001 12001 8082 8000 8080  
ENTRYPOINT ["/opt/start.sh"]  

