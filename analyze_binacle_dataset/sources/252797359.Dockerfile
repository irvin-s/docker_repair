# The base image – 14.04 still the latest LTS package as of  
# 18 Feb 2016  
FROM ubuntu:14.04  
MAINTAINER Andrew Morgan "andrew.morgan@mongodb.com"  
# "ENV" sets environment variables within the container and for any  
# Dockerfile commands below this point  
ENV REFRESHED_AT 2016-2-18  
# AGENT_PACKAGE set to the name of the automation agent package file within  
# the container's file system  
ENV AGENT_PACKAGE mongodb-mms-automation-agent-manager_latest_amd64.deb  
  
# Refreshes the APT package cache within the image (in a layer on top of the  
# base image) and then installs "Common CA certificates" and "Cyrus SASL -  
# authentication abstraction library" packages.  
RUN apt-get -qqy update && \  
apt-get install -qqy \  
ca-certificates \  
libsasl2-2  
  
# MongoDB Cloud Manager automation  
# Create a volume for the automation agent and mongod to use; run  
# `docker inspect container_name` on the Docker host to see what directory  
# on the host it gets mapped to  
VOLUME ["/var/lib/mongodb-mms-automation", "/data"]  
  
# Copies the automation agent package from the directory from which the  
# image is being developed into the image's /root directory  
ADD ./${AGENT_PACKAGE} /root/  
  
# Install the automation agent package in the image  
RUN dpkg -i /root/${AGENT_PACKAGE}  
  
# Change the owner for that directory within the image  
RUN chown mongodb:mongodb /data  
  
# informs Docker that the container listens on port 2700 (default MMS  
# automation port) at runtime.  
# EXPOSE does not make the ports of the container accessible to the host. To  
# do that, you must use either the -p flag to publish a range of ports or the  
# -P flag to publish all of the exposed ports. You can expose one port number  
# and publish it externally under another number.  
EXPOSE 27000  
# Execute the automation agent when the container is run; command line  
# arguments after the image name in `docker run ...` will be passed through.  
# Can override with `docker run --entrypoint`  
ENTRYPOINT ["/opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent"]  

