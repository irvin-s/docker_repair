# Storm rig for testing.
FROM piggybanksqueal/base
MAINTAINER James Lampton <jlampton@gmail.com>

# Install supervisor
RUN yum install -y supervisor

# Configure Storm
RUN echo 'storm.zookeeper.servers: ["zookeeper"]' >> /opt/storm/conf/storm.yaml

# Setup supervisord
ADD supervisor.d/*.ini /etc/supervisor.d/
RUN cat /etc/supervisor.d/*.ini >> /etc/supervisord.conf

# Expose ui
EXPOSE 8080
# Expose logviewer
EXPOSE 8000
# Expose nimbus 
EXPOSE 6627

ENTRYPOINT ["/usr/bin/supervisord", "-n"]
