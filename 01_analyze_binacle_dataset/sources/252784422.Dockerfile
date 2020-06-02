FROM phusion/baseimage:0.9.10  
  
MAINTAINER Moto Ohno! <moto@bittorrent.com>  
  
# Set correct environment variables.  
ENV HOME /root  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
ENTRYPOINT ["/sbin/my_init"]  
  
RUN apt-get update && apt-get install -y \  
python2.7 \  
python-dev \  
build-essential \  
make \  
gcc \  
python-pip \  
python-mysqldb  
  
ADD app/requirements.txt /var/www/requirements.txt  
  
RUN pip install -r /var/www/requirements.txt  
  
ADD app /var/www  
  
ADD service /etc/service  
  
RUN mkdir /var/log/devapps-portal  
  
ENV PORTAL_CONFIG /var/www/prod.cfg  
  
EXPOSE 5000 22  

