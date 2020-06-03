FROM ubuntu:14.04  
MAINTAINER didstopia  
  
# Run a quick update/upgrade  
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge  
  
# Install for Drone, then install Drone  
RUN apt-get -y install git wget openssh-client git-core  
RUN wget http://downloads.drone.io/master/drone.deb  
RUN dpkg -i drone.deb  
  
# Expose necessary ports  
EXPOSE 80  
EXPOSE 443  
# Setup default environment variables for the server  
ENV DRONE_SERVER_PORT :80  
ENV DRONE_DATABASE_DATASOURCE /var/lib/drone/drone.sqlite  
  
# This should be mounted on the host if possible  
VOLUME /var/run/docker.sock  
  
# Start the server  
CMD /usr/local/bin/droned  

