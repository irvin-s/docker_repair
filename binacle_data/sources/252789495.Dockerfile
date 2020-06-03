FROM nginx:latest  
  
MAINTAINER Dao Anh Dung <dung13890@gmail.com>  
  
ENV TERM xterm  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY serve.sh /serve.sh  
RUN chmod +x /*.sh  
RUN usermod -u 1000 www-data  
  
CMD ["nginx"]  
  
EXPOSE 80 443  

