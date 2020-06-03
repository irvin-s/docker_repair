FROM lyft/envoy:latest
RUN apt-get update && apt-get install -y \
    dnsutils \
    net-tools \
    curl \
    build-essential \
    git \
    libjpeg-dev \
    python \
    python-pip

COPY envoy.json start-envoy.sh hot-restarter.py restart-envoy.sh /
RUN chmod +x /start-envoy.sh && chmod +x /hot-restarter.py && chmod +x /restart-envoy.sh
CMD ["/hot-restarter.py", "/start-envoy.sh"]
