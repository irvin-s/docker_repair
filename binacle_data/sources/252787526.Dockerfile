#####################################################################  
# broadtech/debian-stretch-nginx  
# This Dockerfile creats an image that deploys Nginx  
# web server on Debian Linux ( Stretch )  
# To deploy nginx on debian stretch just run this single command  
#  
# $ sudo docker run broadtech/debian-stretch-nginx  
#  
# You cound customize this Docker file to create your own image  
  
# Base Image  
FROM debian  
  
LABEL "vendor"="BroadTech Innovations PVT LTD"  
LABEL "vendor.url"="http://www.broadtech-innovations.com/"  
LABEL "maintainer"="sgeorge.ml@gmail.com"  
  
# Update Local Repository Index  
RUN apt-get update  
  
# Upgrade packages in base image and apply security updates  
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yq  
  
# Install Nginx  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq nginx  
  
# Remove retrieved package files from local cache  
RUN apt-get clean  
  
# Cleanup unwanted files  
RUN rm -rf /var/lib/apt/lists/  
  
# Donot daemonize Nginx ( Run in Foreground ). This is required  
# to prevent the container from exiting soon after start  
# To run this container in the back ground use the -d option  
#  
# $ sudo docker run -d broadtech/debian-stretch-nginx  
#  
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf  
  
# Open port to access Nginx  
EXPOSE 80  
  
# Run Nginx when container starts  
CMD ["/usr/sbin/nginx"]  
  
# -------------------------END----------------------------------------#  
  
  

