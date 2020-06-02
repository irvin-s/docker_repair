# Specify Docker Image
FROM ubuntu:18.04

# Specify the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Setup
RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -y python3-pip
RUN apt-get install -y python3.7

# Optional
RUN apt-get install -y git
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt
RUN apt-get install -y vim
COPY .vimrc /root
