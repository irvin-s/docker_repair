FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-venv \
    python3-dev \
    libjpeg-dev \
    zlib1g-dev

COPY . /home/

RUN cd /home && \
    chmod +x start

EXPOSE 4242
WORKDIR /home

ENTRYPOINT ["/home/start"]
