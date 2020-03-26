FROM alpine:3.5

LABEL maintainer "jeorry@gmail.com"

RUN apk add --update \
    ca-certificates \
    curl \
    git \
    openssh-client \
    python \
    py-boto \
    py-dateutil \
    py-httplib2 \
    py-jinja2 \
    py-paramiko \
    py-pip \
    py-setuptools \
    py-yaml \
    unzip \
    tar && \
  pip install --upgrade pip python-keyczar && \
  pip install pyvmomi && \
  rm -rf /var/cache/apk/*

RUN mkdir /etc/ansible/ /ansible
RUN echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

RUN \
  curl -fssl https://releases.ansible.com/ansible/ansible-2.3.0.0.tar.gz -o ansible.tar.gz && \
  tar -xzf ansible.tar.gz -C ansible --strip-components 1 && \
  rm -fr ansible.tar.gz /ansible/docs /ansible/examples /ansible/packaging

RUN mkdir -p /ansible/playbooks && \
    mkdir -p /etc/ssl/certs/ && update-ca-certificates --fresh

WORKDIR /ansible/playbooks

RUN git clone https://github.com/jeorryb/netapp-ansible.git /github

ADD netapp-manageability-sdk-5.6.zip /nmsdk/nmsdk.zip
RUN unzip -j /nmsdk/nmsdk.zip "netapp*/lib/python/NetApp/*.py" -d /nmsdk && \
    rm -f /nmsdk/nmsdk.zip

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING False
ENV ANSIBLE_LIBRARY /github/library
ENV ANSIBLE_RETRY_FILES_ENABLED False
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib:/nmsdk

ENTRYPOINT ["ansible-playbook"]
