FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        curl jq \
        python python-dev python-pip python-setuptools \
    && rm -r /var/lib/apt/lists/*

EXPOSE 8000

RUN pip install --upgrade pip
RUN pip install flask requests

WORKDIR /
COPY start.sh /
COPY app.py /

CMD ["bash", "start.sh"]
