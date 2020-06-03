FROM ubuntu:14.04
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>

# Install the unzip utility.
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install unzip

# Add the consul agent binary and web ui static files.
ADD https://dl.bintray.com/mitchellh/consul/0.2.1_linux_amd64.zip /tmp/consul.zip
ADD https://dl.bintray.com/mitchellh/consul/0.2.1_web_ui.zip /tmp/web_ui.zip
# Create the consul install directory.
RUN mkdir -p /opt/consul/data

# Install the consul agent and web ui.
RUN unzip /tmp/consul.zip -d /opt/consul/bin/
RUN unzip /tmp/web_ui.zip -d /opt/consul/web_ui/
RUN chmod +x /opt/consul/bin/consul

# Expose the service ports:
#  - Server RPC (8300)
#  - Serf LAN (8301)  
#  - Serf WAN (8302)
#  - Client RPC (8400)
#  - HTTP API (8500)
#  - DNS (8600)
EXPOSE 8300 8301 8302 8400 8500 8600/udp

# Set the entrypoint to be a simple agent.
ENTRYPOINT ["/opt/consul/bin/consul", "agent", "-data-dir", "/opt/consul/data"]
