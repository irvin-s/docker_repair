FROM nginx:1.7  
MAINTAINER Ian Babrou <ibobrik@gmail.com>  
  
ADD ./nginx.conf /etc/nginx/nginx.conf  
  
ADD ./run.sh /run.sh  
  
CMD ["/run.sh"]  

