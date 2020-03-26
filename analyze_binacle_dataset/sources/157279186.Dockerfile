FROM python:2.7-slim

ENV ETCDCTL_VERSION v2.3.1
ENV CONFD_VERSION 0.12.0-alpha3
ENV DUMB_INIT_VERSION 1.2.0

# Install Native dependencies
RUN \
  apt-get update && \
  apt-get upgrade -y  && \
  # Curl Wget
  apt-get install -y curl wget && \
  
  # Rabbitmq
  wget -qO - https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  apt-get install -y rabbitmq-server && \
  
  rabbitmq-plugins enable rabbitmq_management && \
  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
  sed --follow-symlinks \
    -e 's/-rabbit error_logger.*/-rabbit error_logger tty \\/' \
    -e 's/-rabbit sasl_error_logger.*/-rabbit sasl_error_logger tty \\/' \
    -e 's/-sasl sasl_error_logger.*/-sasl sasl_error_logger tty \\/' \
    -i  /usr/lib/rabbitmq/bin/rabbitmq-server && \
  
  # Etcd
  curl -L https://github.com/coreos/etcd/releases/download/$ETCDCTL_VERSION/etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz -o /tmp/etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz && \
  cd /tmp && gzip -dc etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz | tar -xof - && \
  cp -f /tmp/etcd-$ETCDCTL_VERSION-linux-amd64/etcdctl /usr/local/bin && \

  # Supervisor
  pip install supervisor==3.3.1 supervisor-stdout && \
  mkdir -p /var/log/supervisor && \
  
  # Confd
  curl -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd && \
  chmod 555 /usr/local/bin/confd && \

  # Dumb Init
  wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 && \
  chmod +x /usr/bin/dumb-init && \

  # Cleanup
  apt-get clean && \
  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /tmp/*

#Supervisor Config
ADD etc/supervisor /etc/supervisor
RUN ln -sf /etc/supervisor/supervisord.conf /etc/supervisord.conf

#Confd Defaults
ADD etc/confd /etc/confd

#Add custom scipts
ADD bin /usr/local/bin
RUN chmod -R +x /usr/local/bin

# Define mount points.
VOLUME ["/var/lib/rabbitmq"]

EXPOSE 5672 44001 15672 25672 4369

ENTRYPOINT ["/usr/bin/dumb-init", "/usr/local/bin/supervisord-wrapper.sh"]
