FROM ubuntu:xenial  
  
# Set the env variable DEBIAN_FRONTEND to noninteractive  
ENV DEBIAN_FRONTEND noninteractive  
  
# Change sources to a server in Portugal to make package download faster  
RUN sed -i 's/http:\/\//http:\/\/pt./g' /etc/apt/sources.list  
  
# Install Apache  
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade  
RUN apt-get -y install apache2  
  
# Enable Apache Modules  
RUN a2enmod rewrite proxy_fcgi expires headers  
  
COPY conf /  
RUN chmod +x /usr/local/bin/httpd-foreground  
  
# Create a user to match the GUID of our user  
# TODO A better solution is required because machines may have multiple users  
RUN useradd application  
WORKDIR /opt/application  
  
EXPOSE 80  
ENTRYPOINT ["httpd-foreground"]

