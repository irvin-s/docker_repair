FROM ubuntu:16.04
MAINTAINER Daniel Ferreira <daniel.c.ferreira@tecnico.ulisboa.pt>

RUN apt-get update && apt-get install -y \
  apt-utils \
  build-essential \
  wget \
  unzip \
  git \
  libopenblas-dev \
  python-dev \
  python-pip \
  python-nose \
  python-numpy \
  python-scipy

COPY src /src
COPY scripts /scripts
COPY preprocessing /preprocessing
#COPY data /data  # Uncomment this line if you want to copy the corpora to the Docker container
COPY requirements.txt .

RUN pip install -r requirements.txt
RUN echo "[global]\non_unused_input = ignore" > /root/.theanorc
