FROM dickeyxxx/base  
MAINTAINER Jeff Dickey jeff@dickeyxxx.com  
  
RUN apt-get -y install nginx  
  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
  
EXPOSE 80  
CMD ["nginx"]  

