# Start with base image.
FROM ubuntu:latest
MAINTAINER David Harper "david@pandastrike.com"

# Add the necessary technologies to assemble this app.
RUN apt-get update
RUN apt-get -y install git
RUN apt-get -y install nodejs
RUN apt-get -y install npm

# Pull the app from its git repository and place it in this image.
RUN cd /var;git clone https://github.com/pandastrike/panda-panopticon.git
RUN cd /var/panda-panopticon;npm install

# Expose ports needed by the app.
EXPOSE 3000
EXPOSE 3001

# The app is ready to go.  Start it up.
CMD ["/usr/bin/nodejs", "/var/panda-panopticon/server.js"]
