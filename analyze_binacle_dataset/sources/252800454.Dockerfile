FROM php:5.6  
LABEL maintainer "thephenix@gmail.com"  
  
COPY install_deps.sh /  
  
RUN /install_deps.sh

