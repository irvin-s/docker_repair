FROM ubuntu:xenial

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y unzip wget curl git make jq openssh-client && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz && \
    tar xvzf godeb-amd64.tar.gz && \
    ./godeb install 1.10 && \
    rm -rf godeb* *.deb

ENV TERRAFORM_VERSION 0.11.3
RUN curl -L -O "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    mv terraform /usr/local/bin/ && \
    rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

