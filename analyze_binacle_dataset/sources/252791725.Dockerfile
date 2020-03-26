# Pull from base Ubuntu image  
FROM ubuntu:14.04  
# Do system updates and install dependencies  
RUN apt-get update  
RUN apt-get -y upgrade  
RUN apt-get -y install git wget  
RUN apt-get clean  
  
# Download Drone.io  
RUN wget http://downloads.drone.io/master/drone.deb  
RUN dpkg -i drone.deb  
  
# Expose the Drone.io port  
EXPOSE 8080  
ENV DRONE_SERVER_PORT 0.0.0.0:8080  
ENV DRONE_DATABASE_DATASOURCE /var/lib/drone/drone.sqlite  
  
# The command we'll be running when the container starts  
ENTRYPOINT ["/usr/local/bin/droned"]  
  

