############################################################  
# Dockerfile to build ChatBotT-Back  
# Based on Debian  
############################################################  
  
# Set the base image to Debian  
FROM debian  
  
# File Author / Maintainer  
MAINTAINER Julien Stroheker  
  
# Create app folder, where the magic is !  
RUN mkdir -p /usr/src/app  
  
# Set the default directory where CMD will execute  
WORKDIR /usr/src/app  
  
# Update the sources list  
RUN apt-get update  
  
# Install basic applications  
RUN apt-get install -y git curl vim  
  
# Install Python and Basic Python Tools  
RUN apt-get install -y python python-dev python-distribute python-pip  
  
# Get flask to download and install requirements:  
RUN pip install flask  
  
# Get aiml to download and install requirements:  
RUN pip install aiml  
  
# Copy the application folder inside the container  
COPY app /usr/src/app  
  
# Expose port  
EXPOSE 12345  
  
# Set the default command to execute  
# when creating a new container  
# lunch the webserver  
CMD python2 /usr/src/app/app.py

