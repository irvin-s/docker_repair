# Use a standard Node image from Docker Hub 
FROM node:boron

# The Dockerfile's author
LABEL Usama Ashraf

# Create a directory in the container where the code will be placed
RUN mkdir -p /backend-dir-inside-container

# Set this as the default, working directory.
# We'll land here when we SSH into the container.
WORKDIR /backend-dir-inside-container

# Copy everything inside src to our directory in the container
#ADD ./src /backend-dir-inside-container

# Our Nginx container will forward HTTP traffic to containers of 
# this image via port 3000.
EXPOSE 3000
