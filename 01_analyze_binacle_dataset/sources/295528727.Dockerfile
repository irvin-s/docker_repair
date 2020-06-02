# Used to build a Lambda package with a compiled dependency
#
# Python's cryptography package must be compiled on the target architecture
# when being installed. So to include the correct dependencies the `pip install`
# is ran directly on an Amazon Linux machine via Docker.

FROM amazonlinux:latest

WORKDIR /root

COPY . .

# Install pip
RUN curl -O -s https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py

# cryptography dependencies
RUN yum install -y \
    gcc \
    libffi-devel \
    python27-devel \
    openssl-devel

RUN yum install -y zip

CMD make build
