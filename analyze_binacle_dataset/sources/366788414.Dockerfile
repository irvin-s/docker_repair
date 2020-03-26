############################################################
# Dockerfile to build Nginx Amplify Agent with N+ container
# Based on Ubuntu 14.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Mike Belov

ARG VAULT_ADDR='https://vault.ci.nginx.com'
ARG VAULT_SKIP_VERIFY=true
ARG VAULT_TOKEN
RUN echo ${VAULT_TOKEN}

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y -q wget apt-transport-https \
 && apt-get install -y -qq curl libcurl3 libcurl3-dev php5-curl && apt-get -y -qq install jq ca-certificates

# get vault
RUN curl -Ss https://releases.hashicorp.com/vault/0.10.0/vault_0.10.0_linux_amd64.zip \
    | gunzip - > /usr/local/bin/vault \
    && chmod +x /usr/local/bin/vault

# setup NGINX repo certs for N+
RUN mkdir -p /etc/ssl/nginx \
    && VAULT_TOKEN=${VAULT_TOKEN} vault kv get -format=json certs-dev/nginx-repo.crt  \
    | jq -r .data.data.cert > /etc/ssl/nginx/nginx-repo.crt \
    && VAULT_TOKEN=${VAULT_TOKEN} vault kv get -format=json certs-dev/nginx-repo.key  \
    | jq -r .data.data.key > /etc/ssl/nginx/nginx-repo.key \
    && chmod +r /etc/ssl/nginx/nginx-repo.*

# Get other files required for installation
RUN wget -q -O - http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN wget -q -O /etc/apt/apt.conf.d/90nginx https://cs.nginx.com/static/files/90nginx

RUN printf "deb https://plus-pkgs.nginx.com/ubuntu `lsb_release -cs` nginx-plus\n" >/etc/apt/sources.list.d/nginx-plus.list

# Install NGINX Plus
RUN apt-get update && apt-get install -y nginx-plus

# Install basic applications
RUN apt-get install -y --fix-missing tar curl nano wget dialog net-tools build-essential
# RUN apt-get install -y --fix-missing apt-transport-https

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute
RUN curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0'

# Copy the application folder inside the container
ADD . /amplify
ADD requirements.txt /etc/naas/requirements.txt

# Install agent requirements:
RUN pip install -r /etc/naas/requirements.txt

ENV AMPLIFY_ENVIRONMENT development
ENV PYTHONPATH /amplify/

# Set the default directory where CMD will execute
WORKDIR /amplify

# add stub status
ADD nginx.conf /etc/nginx/nginx.conf

# add ssl
ADD amplify-agent-test.crt /etc/nginx/certs.d/amplify-agent-test.crt
ADD amplify-agent-test.key /etc/nginx/certs.d/amplify-agent-test.key

CMD nginx && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
