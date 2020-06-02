FROM envoyproxy/envoy:latest
RUN apt-get update && apt-get install -y \
    dnsutils \
    net-tools \
    curl \
    build-essential \
    git \
    libjpeg-dev \
    python \
    python-pip

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs && npm install --global yarn
RUN git clone https://github.com/bats-core/bats-core.git && cd bats-core/; ./install.sh /usr/local


COPY waitloop.sh start-envoy.sh hot-restarter.py restart-envoy.sh /
RUN chmod +x /waitloop.sh && chmod +x /start-envoy.sh && chmod +x /hot-restarter.py && chmod +x /restart-envoy.sh
CMD ["/waitloop.sh"]

