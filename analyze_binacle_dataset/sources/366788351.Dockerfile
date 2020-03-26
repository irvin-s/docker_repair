############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on Centos6
############################################################

# Set the base image to Centos
FROM centos:6

# File Author / Maintainer
MAINTAINER Mike Belov

# Install basic applications
RUN yum -y install tar curl wget net-tools redhat-lsb initscripts
RUN yum -y groupinstall 'Development Tools'

# Install nginx
ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx
RUN mkdir /run

# Copy the application folder inside the container
ADD . /amplify
ADD requirements.txt /etc/naas/requirements.txt

# Install Python and Basic Python Tools
RUN yum -y install python python-devel python-distribute
RUN wget --no-check-certificate https://bootstrap.pypa.io/2.6/get-pip.py \
 && python get-pip.py --user \
 && rm -f get-pip.py \
 && ~/.local/bin/pip install setuptools --user \
 && ~/.local/bin/pip install setuptools --upgrade --user \
 && ~/.local/bin/pip install wheel==0.29.0 --user \
 && ~/.local/bin/pip install -r /etc/naas/requirements.txt

ENV AMPLIFY_ENVIRONMENT development
ENV PYTHONPATH /amplify/

# Set the default directory where CMD will execute
WORKDIR /amplify

# add stub status
ADD nginx.conf /etc/nginx/nginx.conf

# add ssl
ADD amplify-agent-test.crt /etc/nginx/certs.d/amplify-agent-test.crt
ADD amplify-agent-test.key /etc/nginx/certs.d/amplify-agent-test.key

CMD /usr/sbin/nginx && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
