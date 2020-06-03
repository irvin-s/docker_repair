FROM nginx:1.11.9  
MAINTAINER Leandro Gomez<lgomez@devartis.com>  
  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
COPY command.sh .  
CMD ["bash", "command.sh"]  

