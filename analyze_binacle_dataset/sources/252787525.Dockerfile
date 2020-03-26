#####################################################################  
# broadtech/debian-stretch-mongodb  
# This Dockerfile creats an image that deploys MongoDB  
# on Debian Linux ( Stretch )  
# To deploy MongoDB on Stretch run a single command  
#  
# $ sudo docker run broadtech/debian-stretch-mongodb  
#  
# To run MongoDB in the background use the -d option  
#  
# $ sudo docker run -d broadtech/debian-stretch-mongodb  
#  
# You could use this Dockerfile to create your own docker image  
  
# Base image  
FROM debian  
  
LABEL "vendor"="BroadTech Innovations PVT LTD"  
LABEL "vendor.url"="http://www.broadtech-innovations.com/"  
LABEL "maintainer"="sgeorge.ml@gmail.com"  
  
# Update Local Repository Index  
RUN apt-get update  
  
# Upgrade packages in the base image and apply security updates  
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yq  
  
# Install package utils  
RUN DEBIAN_FRONT=noninteractive apt-get install -yq apt-utils  
  
# Install MongoDB  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq mongodb  
  
# Remove package files fetched for install  
RUN apt-get clean  
  
# Remove unwanted files  
RUN rm -rf /var/lib/apt/lists/  
  
# Open MongoDB default port  
EXPOSE 27017  
  
# Pass Database Location on file system as parameter to MongoDB  
CMD ["--dbpath", "/var/lib/mongodb"]  
  
# Start MongoDB when container runs  
ENTRYPOINT ["/usr/bin/mongod"]  
  
# MongoDB sometimes comes without a default password and this has  
# caused exposure of Data on the Internet.  
  
# https://www.shodan.io/search?query=mongodb  
  
# So please be sure to provide passwords for users if you wish  
# to expose your MongoDB server to the outside world.  
#--------------------------END--------------------------------------#  

