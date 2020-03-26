      FROM alpine:edge
      MAINTAINER Mateusz Pawlowski
      RUN apk --no-cache add \
        py-crypto py-yaml py-jinja2  py-paramiko py-setuptools git py2-pip perl py-simplejson rsync \
        py-httplib2 py-psycopg2 openssh sshpass py-dnspython py-netaddr openssl curl\
         && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/  py-netifaces py-msgpack \
      && rm -rf /var/cache/apk/*
      RUN pip install --upgrade setuptools
      RUN pip install python-keyczar boto boto3 botocore hvac python-consul
      RUN mkdir /etc/ansible/
      RUN echo "[local]" > /etc/ansible/hosts ; echo "localhost ansible_connection=local" >> /etc/ansible/hosts
      RUN mkdir /opt/ansible/ -p
      RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
      WORKDIR /opt/ansible/ansible
      RUN git checkout  v2.5.5
      RUN git submodule update --init
      ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
      ENV PYTHONPATH /opt/ansible/ansible/lib
      ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
      RUN pip install -t /opt/vault --no-deps ansible-modules-hashivault && \
          cp -r /opt/vault/ansible/* /opt/ansible/ansible/lib/ansible/ && \
          rm -rf /opt/vault
      RUN pip uninstall -y cryptography
      RUN mkdir /ansible
      WORKDIR /ansible

