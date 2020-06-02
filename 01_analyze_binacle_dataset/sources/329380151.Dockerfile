# Use the newest LTS (long term support) version of ubuntu
FROM ubuntu:16.04

# Update the list of packages for the system installer apt
# https://help.ubuntu.com/lts/serverguide/apt.html
RUN apt-get update

# Install python 3, pip & venv (virtual env) with apt
RUN apt-get install -y python3 python3-pip python3-venv

# Make a directory to work in
RUN mkdir -p /opt/project

# Move to the new directory
WORKDIR /opt/project

# Make a non-root user
RUN useradd unc

# Make that user the owner of the files in our project directory
RUN chown -R unc /opt/project

# Switch to the unc user
USER unc