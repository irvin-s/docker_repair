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

# Create a virtualenv
RUN python3 -m venv /opt/project/env

# Create a requirements.txt
RUN echo "django==2.0\npsycopg2" > /opt/project/requirements.txt

# PIP install the requirements
RUN /opt/project/env/bin/pip3 install -r requirements.txt

# Use the Django default StartProject command
RUN /opt/project/env/bin/django-admin startproject mysite

# Remove old settings.py
RUN rm /opt/project/mysite/mysite/settings.py

# Replace settings.py with our modified version
COPY settings.py /opt/project/mysite/mysite/settings.py

# Switch to the unc user
USER unc