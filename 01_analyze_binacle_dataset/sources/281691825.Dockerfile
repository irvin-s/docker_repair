# DockerFile using Nginx base image and website source code copy from current directory
# * Build image with the docker file and run <commands below> 
# References:
# * https://www.katacoda.com/courses/docker/create-nginx-static-web-server

# Base Nginx docker image
FROM nginx:alpine

# Maintainer
MAINTAINER Srinivas Piskala Ganesh Babu "spg349@nyu.edu"

# Copy the DevOps repository contents present in the current directory to the default nginx web hosting directory
COPY DevOps /usr/share/nginx/html

# Usage:
# * To update the website source files, 
# ** Clone the gcallah/DevOps repo at the same directory where dockerfile exists <git clone>
# *** build a new image with this dockerfile - "docker build -f DockerFile -t devopsweb ." 
