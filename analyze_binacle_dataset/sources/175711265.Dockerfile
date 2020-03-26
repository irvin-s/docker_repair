FROM cromo/devkitarm-3ds
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"

RUN apt-get update && \
  apt-get install -y \
    python3-pip \
    python3 && \
  rm -rf /var/lib/apt/lists/*
RUN pip-3.2 install Pillow

WORKDIR /source
CMD ["bash"]