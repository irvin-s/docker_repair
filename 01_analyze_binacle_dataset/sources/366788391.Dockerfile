############################################################
# Dockerfile to build Nginx Amplify Agent with N+ container
# Based on Ubuntu 16.04
############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt-get update

RUN apt-get install  -y --fix-missing tar curl nano wget dialog net-tools build-essential apt-transport-https jq \
    python python-dev python-distribute software-properties-common
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get update && apt-get install -y certbot

# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
ADD docker/test-vanilla/nginx-repo.crt /etc/ssl/nginx/
ADD docker/test-vanilla/nginx-repo.key /etc/ssl/nginx/

RUN wget --no-check-certificate https://bootstrap.pypa.io/ez_setup.py -O - | python \
    && easy_install pip \
    && easy_install supervisor

ADD docker/test-vanilla/requirements /etc/naas/requirements

# Install agent requirements:
RUN pip install -r /etc/naas/requirements

# Install test requirements
RUN pip install \
    pytest \
    pytest-xdist \
    pyhamcrest \
    requests_mock

ENV AMPLIFY_ENVIRONMENT testing
ENV PYTHONPATH /amplify
ENV CTR_TEST true

# Copy the application folder inside the container
ADD . /amplify
# Set the default directory where CMD will execute
WORKDIR /amplify

CMD bash
