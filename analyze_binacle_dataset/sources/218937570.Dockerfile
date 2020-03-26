# FROM dockerfile/haproxy
  # dockerfile/haproxy is not available on dockerhub anymore
  # the following lines were taken directly from "dockerfile/haproxy" and "dockerfile/ubuntu" github repo

  # from dockerfile/ubuntu
FROM ubuntu:14.04


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
# CMD ["bash"]

# add PPA to get haproxy >= 1.5
RUN apt-get install -y software-properties-common && add-apt-repository ppa:vbernat/haproxy-1.6

# Install confd on the container
# Install Haproxy.
RUN apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y haproxy wget \
  && wget https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 \
  && mv confd-0.7.1-linux-amd64 /usr/local/bin/confd \
  && chmod u+x /usr/local/bin/confd \
  && mkdir -p /etc/confd/{conf.d,templates} \
  && sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list \
  && sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy \
  && rm -rf /var/lib/apt/lists/*

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY haproxy.toml /etc/confd/conf.d/haproxy.toml
COPY haproxy.cfg.tmpl /etc/confd/templates/haproxy.cfg.tmpl

# rsyskig config for haproxy
COPY haproxy.conf /etc/rsyslog.d/haproxy.conf

COPY start-service /usr/local/bin/start-service
RUN chmod +x /usr/local/bin/start-service

# COPY haproxy-etcd-service-announcer /usr/local/bin/haproxy-etcd-service-announcer
# RUN chmod +x /usr/local/bin/haproxy-etcd-service-announcer

EXPOSE 80 1936

VOLUME /var/log
# VOLUME /logstash_forwarder

CMD ["/usr/local/bin/start-service"]
