# Create an image based on Linux Ubuntu  
FROM ubuntu:16.04  
# Install Apache Server  
RUN apt-get update && apt-get install -y apache2 \  
# Install python3 and pip3  
python3-pip \  
# Install sphinx  
&& pip3 install sphinx sphinx-autobuild sphinx_rtd_theme \  
# Create folder source  
&& mkdir /var/www/source/ \  
# Remove existing HTML file  
&& rm -rf /var/www/html/*  
  
# Expose container port  
EXPOSE 80  
# Set default command to run when starting the container  
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]  
  

