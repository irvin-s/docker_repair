FROM ubuntu:trusty
MAINTAINER Laurens Van Houtven, _@lvh.io

RUN apt-get update # 4 Mar 2014 17:07
RUN apt-get install -y python-setuptools python-pip git build-essential python-dev libffi-dev
RUN pip install tox

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs ruby
RUN gem install compass --pre

RUN git clone https://github.com/crypto101/website.git /var/website # 24 Mar 2014 16:15

WORKDIR /var/website/static
RUN npm install -g grunt-cli 2>&1
RUN npm install 2>&1 # 4 Mar 2014 17:07
RUN grunt build

WORKDIR /var/website
RUN tox -e py27

RUN apt-get remove -y python-setuptools python-pip git build-essential python-dev libffi-dev
RUN gem list | cut -d" " -f1 | xargs gem uninstall -aIx
RUN apt-get remove -y nodejs ruby
RUN apt-get -y autoremove

RUN echo "root - nofile 32768" >> /etc/security/limits.conf
RUN echo "nobody - nofile 32768" >> /etc/security/limits.conf
RUN sysctl -p
RUN echo "session required pam_limits.so" > /etc/pam.d/common-session
RUN echo "session required pam_limits.so" > /etc/pam.d/common-session-noninteractive

ENV ENV_VARS_PATH /var/website/local/env-vars.json
ENV CERTIFICATE_PATH /var/website/local/cert-chain.pem
ENV DH_PARAMETERS_PATH /var/website/local/dh-parameters.pem
ENV STATIC_PATH /var/website/static/dist
EXPOSE 80 443
VOLUME ["/var/website/local"]
ENTRYPOINT /var/website/run-in-container
