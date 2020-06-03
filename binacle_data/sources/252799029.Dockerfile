FROM ubuntu:14.04  
MAINTAINER Yaroslav Admin <devoto13@gmail.com>  
  
# Base  
ENV LANG en_US.UTF-8  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN locale-gen en_US en_US.UTF-8  
RUN dpkg-reconfigure locales  
RUN apt-get update  
  
RUN apt-get install -y python-software-properties  
  
# Supervisor  
RUN apt-get install supervisor -y  
RUN update-rc.d -f supervisor disable  
  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
# Start Script  
ADD startup /usr/local/bin/startup  
RUN chmod +x /usr/local/bin/startup  
  
CMD ["/usr/local/bin/startup"]  
  
# Install global dependencies  
RUN apt-get install -y python python-dev python-setuptools python-pip  
RUN pip install gunicorn setproctitle  
  
# Install gunicorn running script  
ADD run /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
  
# Volumes  
VOLUME ["/root/app/logs"]  
  
# Ports  
EXPOSE 80  

