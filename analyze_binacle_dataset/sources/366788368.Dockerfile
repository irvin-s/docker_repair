############################################################
# Dockerfile to build Nginx Amplify Agent autotests
# Based on Gentoo
############################################################

# Set the base image to Ubuntu
FROM gentoo/stage3-amd64

# File Author / Maintainer
MAINTAINER Mike Belov

# Install basic applications
RUN emerge-webrsync
RUN emerge app-arch/tar net-misc/curl net-misc/wget nano dialog sys-apps/net-tools
RUN rm -rf /run && mkdir /run

# Install Python and Basic Python Tools
ADD make.conf /etc/portage/make.conf
RUN emerge python:2.7
RUN eselect python set python2.7

RUN emerge python-daemon
RUN curl https://bootstrap.pypa.io/get-pip.py | python - 'pip==18.1.0'

# Install nginx
RUN emerge -1 portage
RUN emerge nginx

# Copy the application folder inside the container
ADD . /amplify

# Install agent requirements:
RUN emerge dev-vcs/git
RUN pip install rstr==2.2.3 greenlet==0.4.12 gevent==1.1.0 lockfile==0.11.0 netaddr==0.7.18 netifaces==0.10.4 psutil==4.0.0 requests==2.12.4 python-daemon==2.0.6 setproctitle==1.1.10 flup==1.0.2 scandir==1.5 crossplane==0.1.1 \
 && pip install git+git://github.com/esnme/ultrajson@2f1d4874f4f4d2a40a460678004c80e69387c663#egg=ujson

ENV AMPLIFY_ENVIRONMENT development
ENV PYTHONPATH /amplify/

# Set the default directory where CMD will execute
WORKDIR /amplify

# add config
ADD nginx.conf /etc/nginx/nginx.conf

# add ssl
ADD amplify-agent-test.crt /etc/nginx/certs.d/amplify-agent-test.crt
ADD amplify-agent-test.key /etc/nginx/certs.d/amplify-agent-test.key

CMD /usr/sbin/nginx && python /amplify/nginx-amplify-agent.py start --config=/amplify/etc/agent.conf.development && tail -f /amplify/log/agent.log
