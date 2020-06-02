# DOCKER-VERSION 1.0
FROM    ubuntu:latest
#
# Install nodejs npm
#
RUN apt-get update
RUN apt-get install -y nodejs npm
#
# install application
#
COPY . /app
RUN cd /app; npm install

EXPOSE  5000
CMD ["nodejs", "/app/web.js"]
