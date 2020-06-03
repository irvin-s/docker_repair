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

# Add universe repository to /etc/apt/sources.list
# we need it for supervisord
RUN sed -i s/main/'main universe'/ /etc/apt/sources.list

# Update so that sources.list changes take effect
RUN apt-get update

# Install wget
RUN apt-get install wget -y

# Add varnish-cache.org repo
RUN wget -qO - http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
RUN echo "deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0" | tee -a /etc/apt/sources.list

# Update again
RUN apt-get update

# Install
RUN apt-get install -y varnish openssh-server supervisor

# Create privilege separation directory
RUN mkdir -p /var/run/sshd

# Create .ssh directory for authorized keys
RUN mkdir -p /root/.ssh

# Create log directory for supervisor
RUN mkdir -p /var/log/supervisor

# Copy configuration files from the current directory
ADD ./authorized_keys /root/.ssh/
ADD custom.vcl /etc/varnish/
ADD supervisord.conf /etc/supervisor/conf.d/

# Ensure correct permissions for root/.ssh
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && chown -R root /root/.ssh

# Expose ports
EXPOSE 22 80

# Set the default command to execute
# when creating a new container
CMD /usr/bin/supervisord

# Example runline:
# sudo docker run -d -p 2222:22 -p 80:80 cohesiveft/varnish-ssh
