# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# USAGE:
#   $ docker build -t nginx .
#   $ docker run -p 80:80 nginx
#
# Version  1.1
#


# pull base image
FROM williamyeh/ansible:centos7-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#

ENV PLAYBOOK test.yml
RUN ansible-playbook-wrapper -vvv --extra-vars "nginx_use_service=False"

EXPOSE 80


#
# test phase
#

RUN echo "===> Installing curl for testing purpose..."  && \
    yum -y install curl

RUN echo "===> Deploying nginx_status.conf to server for testing..."   && \
    printf "server {\n    listen 80;\n    listen [::]:80;\n\n    server_name _;\n\n    location /nginx_status {\n        # Turn on nginx stats\n        stub_status on;\n    }\n}"   \
    > /etc/nginx/conf.d/nginx_status.conf


VOLUME ["/data"]
ENV    RESULT     /data/result-centos7
COPY   test/run-test.sh /usr/local/bin/


CMD [ "run-test.sh" ]