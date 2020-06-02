FROM envoyproxy/envoy:latest
RUN apt-get update && apt-get install -y \
    dnsutils \
    net-tools \
    curl \
    build-essential \
    git \
    libjpeg-dev \
    python \
    python-pip \
    nodejs \
    npm

RUN npm install --global yarn

COPY start-envoy.sh hot-restarter.py restart-envoy.sh /
RUN chmod +x /start-envoy.sh && chmod +x /hot-restarter.py && chmod +x /restart-envoy.sh
CMD ["/hot-restarter.py", "/start-envoy.sh"]
