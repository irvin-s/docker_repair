FROM mattrix/teamcity-java

# Heavily inspired by: https://github.com/jpetazzo/dind

# Ensure that the latest version of LXC is used
RUN add-apt-repository -y ppa:ubuntu-lxc/daily
RUN apt-get update -y

# Install docker dependencies
RUN apt-get install -y iptables ca-certificates lxc

# Install docker
ADD docker /usr/local/bin/docker

# Install script to start docker
ADD ./wrapdocker.sh /usr/local/bin/wrapdocker.sh
RUN chmod +x /usr/local/bin/docker /usr/local/bin/wrapdocker.sh

# /var/lib/docker cannot be on AUFS, so it has to be a volume
VOLUME /var/lib/docker
