#  
# Ubuntu Dockerfile  
#  
# https://github.com/dockerfile/ubuntu  
#  
FROM ubuntu:14.04  
# Install.  
RUN \  
apt-get update && \  
apt-get install -y software-properties-common && \  
apt-get -y install mysql-client && \  
apt-get -y install postgresql-client && \  
apt-get -y install wget  
  
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
  
# Define working directory.  
WORKDIR /etc/nginx  
RUN apt-get clean  
  
# Copy all config files  
#COPY ./config/default.conf /etc/nginx/conf.d/default.conf  
COPY ./nginx.conf /etc/nginx/nginx.conf  
  
# Define default command.  
CMD nginx  

