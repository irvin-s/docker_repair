# Docker file with Ubuntu Base image and performing apt install of,
# * Nginx - To host the website
# * Git   - To fetch the website resource from the git repository
# References:
# * https://docs.docker.com/get-started/part2/#apppy
# * https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images
# * https://gist.github.com/ivanacostarubio/7044770

# Latest ubuntu base image
FROM ubuntu:latest

# Maintainer
MAINTAINER Srinivas Piskala Ganesh Babu "spg349@nyu.edu"

# Apt update and install - nginx and git
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y git-core

# Fetching the latest source code from the github repo of devOps
RUN git clone https://github.com/gcallah/DevOps

# Clean up of existing files in the default folder
RUN rm /var/www/html/*

# Uploading the webpages and resource to the default nginx config pointer folder
RUN cp -a DevOps/. /var/www/html/

# Expose ports
EXPOSE 80

# Nginx daemon run
CMD ["nginx", "-g", "daemon off;"]

# Usage:
# * Use the docker build command to build an image out of this docker file or pull from rep
# ** command: "docker build -f <name of the docker file> -t <tag of the image> ."
# *** repo to docker pull from: srinivas11789/devopswebsite
