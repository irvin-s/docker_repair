# Use Ubuntu 16.04 as parent image
FROM ubuntu:16.04

# Install system dependencies
RUN apt-get update
RUN apt-get --yes --allow-change-held-packages install python3 python3-pip python-setuptools npm

# Add application code
ADD . /opt/repo

# Install python app dependencies
RUN pip3 install -r /opt/repo/requirements.txt
ENV PYTHONPATH="/opt/repo/src:${PYTHONPATH}"

# Install react app global dependencies
RUN npm install -g watchify
RUN npm install -g browserify

# Add symbolik links
RUN ln -s /opt/repo/sys/bin/raccoon /usr/bin/raccoon
RUN ln -s /opt/repo/sys/bin/raccoonshell /usr/bin/raccoonshell
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Volume for application code
VOLUME /opt/repo

# Setting working directory
WORKDIR /opt/repo/web

#EXPOSE RUNNING EXPOSE
EXPOSE 8888

# Start the app
CMD npm install && npm start