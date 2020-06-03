FROM nginx:latest  
  
MAINTAINER Paolo Chiabrera <paolo.chiabrera@gmail.com>  
  
# Remove the default Nginx configuration file  
RUN rm -v /etc/nginx/nginx.conf  
  
# Copy a configuration file from the current directory  
ADD nginx.conf /etc/nginx/  
  
ADD . /home/d3lirium  
  
# Expose ports  
EXPOSE 80  
  
# Set the default command to execute  
# when creating a new container  
  
CMD service nginx start

