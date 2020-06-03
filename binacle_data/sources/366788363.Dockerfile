############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on Debian 8
############################################################

# Set the base image to Debian
FROM debian:8

# File Author / Maintainer
MAINTAINER Mike Belov

# Update the sources list
RUN apt-get update

# Install basic applications
RUN apt-get install -y tar curl nano wget dialog net-tools build-essential
RUN apt-get install -y --fix-missing nginx

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
