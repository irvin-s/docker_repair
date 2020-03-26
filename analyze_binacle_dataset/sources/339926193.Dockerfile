FROM node

# Set the reset cache variable
ENV REFRESHED_AT 2015-05-04

ENV DEBIAN_FRONTEND noninteractive

# Update packages list
RUN apt-get update -y

# Install useful packages
RUN apt-get install -y strace procps tree vim git curl wget

WORKDIR /usr/local/bin/app/

# Add a file which describes application dependencies 
ADD ./app/package.json /usr/local/bin/app/package.json

# Install required libraries
RUN npm install

# Add the application code to the container
ADD ./app/index.js /usr/local/bin/app/index.js

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DEBIAN_FRONTEND=newt

ENTRYPOINT ["npm"]
CMD ["start"]