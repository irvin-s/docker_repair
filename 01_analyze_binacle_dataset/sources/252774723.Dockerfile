FROM phusion/baseimage:0.9.18  
MAINTAINER Travis B. Hartwell <thartwell@contractor.basho.com>  
  
ENV DEBIAN_FRONTEND "noninteractive"  
ENV DEBCONF_NONINTERACTIVE_SEEN "true"  
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"  
RUN apt-get install -y nginx python-jinja2 python-requests  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
ADD nginx.service /etc/service/nginx/run  
ADD config.service /etc/service/build-config/run  
ADD build-config.py /  

