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
RUN apt-get install -y nginx haproxy openssh-server supervisor

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Create empty directory for logs
RUN mkdir -p /etc/nginx/logs

# Create privilege separation directory
RUN mkdir -p /var/run/sshd

# Create .ssh directory for authorized keys
RUN mkdir -p /root/.ssh

# Create log directory for supervisor
RUN mkdir -p /var/log/supervisor

# Copy configuration files from the current directory
ADD ./nginx.conf /etc/nginx/
ADD ./ssl.key /etc/nginx/ssl/
ADD ./ssl.crt /etc/nginx/ssl/
ADD ./haproxy.cfg /etc/haproxy/
ADD ./authorized_keys /root/.ssh/
ADD supervisord.conf /etc/supervisor/conf.d/

# Ensure correct permissions for root/.ssh
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && chown -R root /root/.ssh

# Expose ports
EXPOSE 22 80 443

# Set the default command to execute
# when creating a new container
CMD /usr/bin/supervisord

# Example runline:
# sudo docker run -d -p 2222:22 -p 80:80 -p 443:443 cohesiveft/haproxy-ssl-ssh
