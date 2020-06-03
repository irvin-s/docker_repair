FROM php:7.1  
LABEL maintainer "thephenix@gmail.com"  
  
COPY install_deps.sh /  
  
RUN /install_deps.sh

