FROM django:1.9.2-python2  
MAINTAINER bradojevic@gmail.com  
  
# Define working directory.  
RUN mkdir -p /opt/app  
RUN echo 'Welcome to django-sandbox!' > /root/welcome  
WORKDIR /opt/app  
VOLUME ['/opt/app']  
  
EXPOSE 8000 8001 8080 8081  
CMD ["tail", "-f", "/root/welcome"]  

