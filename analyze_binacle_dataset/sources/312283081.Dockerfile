FROM ubuntu:14.04
LABEL maintainer="Binbin Zhang"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libopenblas-dev \
    git \
    python3-dev \
    python3-pip \
    swig \
    libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install setuptools tornado==5.0.2 mysqlclient

ADD . /xdecoder
WORKDIR /xdecoder

RUN make server && make clean

RUN pwd && ls

EXPOSE 10086

CMD ["python3", "server/main.py", "config/xdecoder.json"]
