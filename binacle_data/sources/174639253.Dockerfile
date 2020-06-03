FROM ubuntu:14.04.4
ADD http://stedolan.github.io/jq/download/linux64/jq /usr/bin/
RUN chmod +x /usr/bin/jq
RUN apt-get update && apt-get install -y \
    busybox \
    curl \
    dnsmasq \
    iptables \
    monit \
    socat \
    psmisc \
    tcpdump \
    uuid-runtime \
    vim-tiny \
    openssl \
    libssl-dev \
    software-properties-common && \
    add-apt-repository ppa:vbernat/haproxy-1.6 && \
    apt-get update && apt-get install -y haproxy && \
    rm -rf /var/lib/apt/lists
ADD startup.sh /etc/init.d/agent-instance-startup
CMD ["/etc/init.d/agent-instance-startup", "init"]
# Work around overlay bug
RUN touch /etc/monit/conf.d/.hold
