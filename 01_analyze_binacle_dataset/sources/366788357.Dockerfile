############################################################
# Dockerfile to build Nginx Amplify Agent container
# Based on Centos7
############################################################

# Set the base image to Centos
FROM centos:7

# File Author / Maintainer
MAINTAINER Mike Belov

# Install basic applications
RUN yum -y install tar curl wget net-tools redhat-lsb initscripts
RUN yum -y groupinstall 'Development Tools'

# Install Python and Basic Python Tools
RUN yum -y install python python-devel python-distribute
RUN curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0'

# Install nginx
ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y install nginx

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

CMD /usr/sbin/nginx && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
