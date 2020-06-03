FROM alpine:3.6

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

ENV PATH $PATH:/usr/local/bin
ENV TERRAFORM_VER 0.11.1
ENV TERRAFORM_ZIP terraform_${TERRAFORM_VER}_linux_amd64.zip

RUN echo "===> Adding dependencies..."  && \
    apk add --update ca-certificates openssh openssl shadow sudo && \
    rm -rf /var/cache/apk/* && \
    \
    \
    echo "===> Adding docker user..."  && \
    useradd -m -d /home/docker -u 1000 -s /bin/sh docker     && \
    echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'docker:docker' | chpasswd                          && \
    \
    \
    echo "===> Installing Terraform..."  && \
    set -ex && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/${TERRAFORM_ZIP} -O /tmp/${TERRAFORM_ZIP} && \
    unzip /tmp/${TERRAFORM_ZIP} -d /usr/local/bin && \
    rm /tmp/${TERRAFORM_ZIP}
