FROM ubuntu  
  
MAINTAINER Steve <steve@bookingboss.com>  
  
#Install NGINX and related tools  
RUN apt-get update && \  
apt-get install -y wget dialog net-tools && \  
apt-get install -y nginx  
  
#Remove default config file  
RUN rm -v /etc/nginx/nginx.conf  
  
#Add config file from local directory  
ADD nginx.conf /etc/nginx/  
  
#Expose port 80  
EXPOSE 80  
  
#Set default command to execute when container starts up, starts in foreground  
CMD ["nginx", "-g", "daemon off;"] && \  
service nginx start  

