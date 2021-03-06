FROM httpd:2.4.25

RUN apt-get update -y && \
    apt-get install -y python python-pip python-virtualenv dos2unix && \
    mkdir aws && \
    virtualenv aws/env && \
    ./aws/env/bin/pip install awscli && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*