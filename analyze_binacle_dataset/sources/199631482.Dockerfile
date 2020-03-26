# Parent image
FROM ubuntu:16.04

# Install system requirements
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "python-pip", "python3-pip", "r-base"]

# Work from home directory
WORKDIR /home

# Move the directory into the corresponding directory in the container
ADD Beiwe-Analysis Beiwe-Analysis

# Install python and R requirements
RUN ["pip", "install", "--upgrade", "pip"]
RUN ["pip", "install", "-r", "Beiwe-Analysis/Pipeline/python2-requirements.txt"]
RUN ["pip3", "install", "--upgrade", "pip"]
RUN ["pip3", "install", "-r", "Beiwe-Analysis/Pipeline/python3-requirements.txt"]
