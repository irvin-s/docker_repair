FROM resin/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y -q \
    nmap \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["nmap"]
