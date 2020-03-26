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
# we need it for iftop etc.
RUN sed -i s/main/'main universe'/ /etc/apt/sources.list

# make sure everything is up to date
RUN apt-get update

# Install net tools and SSH so that they can be used
RUN apt-get install -y net-tools sysstat iftop tcpstat hping3 nethogs openssh-server

# Add keyfile for SSH access
ADD ./authorized_keys /root/.ssh/

# Ensure correct permissions for root/.ssh
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && chown -R root /root/.ssh

# Expose SSH port
EXPOSE 22

# Run SSH daemon
CMD /usr/sbin/sshd -D

# Example runline:
# sudo docker run -d cohesiveft/net-tools
