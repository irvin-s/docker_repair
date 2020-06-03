#  
# Ubuntu Dockerfile  
#  
# https://github.com/dockerfile/ubuntu  
#  
FROM ubuntu:14.04  
# Install.  
RUN \  
apt-get update && \  
apt-get install -y software-properties-common  
  
# Set environment variables.  
ENV HOME /root  
  
# Define working directory.  
WORKDIR /root  
  
# Define default command.  
CMD ["bash"]  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Nginx.  
RUN \  
add-apt-repository -y ppa:nginx/stable && \  
apt-get update && \  
apt-get install -y nginx && \  
rm -rf /var/lib/apt/lists/* && \  
chown -R www-data:www-data /var/lib/nginx  
  
# Define mountable directories.  
VOLUME ["/etc/nginx/certs", "/var/log/nginx", "/var/www/html"]  
  
# Define working directory.  
WORKDIR /etc/nginx  
  
COPY nginx.conf /etc/nginx/nginx.conf  
CMD nginx  

