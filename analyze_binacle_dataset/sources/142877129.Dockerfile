# DOCKER-VERSION 0.10.0
# Build and run courses webapp

FROM phusion/passenger-full:0.9.9
MAINTAINER Application Development Initiative, infrastructure@adicu.com

# Set correct environment variables.
ENV HOME /root
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Add package.json by itself to allow
# npm install to be cached
# (Docker will rerun when package.json changes)
ADD package.json /home/app/courses/
WORKDIR /home/app/courses

# Install dependencies
RUN npm install -g grunt-cli coffee-script bower
RUN npm install

# Add the courses repo to the image
ADD . /home/app/courses

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build
RUN ["grunt"]

# Now, create a volume to allow temp changes
VOLUME /home/app/courses
