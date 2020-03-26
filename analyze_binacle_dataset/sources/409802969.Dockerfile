FROM ubuntu:12.04

MAINTAINER cohesiveft

# This copyrighted material is the property of
# Cohesive Flexible Technologies and is subject to the license
# terms of the product it is contained within, whether in text
# or compiled form.  It is licensed under the terms expressed
# in the accompanying README.md and LICENSE.md files.
#
# This program is AS IS and  WITHOUT ANY WARRANTY; without even
# the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.

# add universe repository to /etc/apt/sources.list
# we need it for nginx
RUN sed -i s/main/'main universe'/ /etc/apt/sources.list

# make sure everything is up to date
RUN apt-get update
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD ./nginx.conf /etc/nginx/
ADD ./ssl.key /etc/nginx/ssl/
ADD ./ssl.crt /etc/nginx/ssl/

# Create empty directory for logs
RUN mkdir -p /etc/nginx/logs

# Expose ports
EXPOSE 443

# Set the default command to execute
# when creating a new container
CMD service nginx start

# Example runline:
# sudo docker run -d -p 443:443 cohesiveft/nginxssl
