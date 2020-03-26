from python:2.7

RUN apt-get update && apt-get install -y --no-install-recommends \
               python-paramiko \
               python-pip \
               python-pycurl \
               python-dev \
               build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN pip install ansible \
                markupsafe \
                boto \
                boto3

VOLUME ["/usr/src/myapp","/root/.ssh"]
