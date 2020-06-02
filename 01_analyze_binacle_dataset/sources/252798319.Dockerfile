FROM demersus/base  
MAINTAINER Nik Petersen (demersus@gmail.com)  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN rm -rf /etc/nginx/*.d  
RUN rm -rf /etc/nginx/sites-*  
RUN mkdir -p /etc/nginx/conf.d /etc/nginx/host.d /etc/nginx/nginx.d  
ADD etc /etc  
ADD srv /srv  
ADD init /init  
ADD supervisor.conf /etc/supervisor/conf.d/nginx.conf  
EXPOSE 80  

