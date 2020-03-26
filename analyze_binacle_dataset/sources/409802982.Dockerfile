FROM ubuntu:14.04

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

# Make sure everything is up to date
RUN apt-get update
# Packages needed to add OSIF repo
RUN apt-get install -y python-software-properties software-properties-common
# Add OSIF repo
RUN add-apt-repository ppa:oisf/suricata-stable -y
# Update again to add suricata repo
RUN apt-get update 
# Install suricata, oinkmaster, supervisord and openssh
RUN apt-get install -y suricata oinkmaster supervisor openssh-server
# Create logs directory
RUN mkdir -p /var/log/suricata
# Create rules directory
RUN mkdir -p /etc/suricata/rules
# Create privilege separation directory
RUN mkdir -p /var/run/sshd
# Create .ssh directory for authorized keys
RUN mkdir -p /root/.ssh
# Get Emerging Threat open rules
RUN oinkmaster -u http://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz -o /etc/suricata/rules/
# Delete default Suricata config file
RUN rm -v /etc/suricata/suricata.yaml
# Copy configuration files from the current directory
ADD ./authorized_keys /root/.ssh/
ADD ./supervisord.conf /etc/supervisor/conf.d/
ADD ./suricata.yaml /etc/suricata/suricata.yaml
# Ensure correct permissions for root/.ssh
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys && chown -R root /root/.ssh
# Expose ssh
EXPOSE 22
# Set the default command to execute
# when creating a new container
CMD ["/usr/bin/supervisord"]
# Example runline:
# sudo docker run -d -p 2222:22 cohesiveft/suricata
