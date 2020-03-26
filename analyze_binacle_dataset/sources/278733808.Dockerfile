FROM jenkins/java:d93654cc6239
ENV MANAGED_VIRTUALENV_DIRECTORY=/var/managed_virtualenv
USER root
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update
RUN apt-get install -y python3.4 python3.5 python2.7 curl
ENV GET_PIP=https://bootstrap.pypa.io/get-pip.py
RUN curl $GET_PIP | python3.4 && curl $GET_PIP | python3.5 && curl $GET_PIP | python2.7
#RUN python3.4 -m ensurepip && python2.7 -m ensurepip && python3.5 -m ensurepip
RUN python3.4 -m pip install virtualenv && python2.7 -m pip install virtualenv && python3.5 -m pip install virtualenv
RUN python3.5 -m virtualenv --python=python3.5 $MANAGED_VIRTUALENV_DIRECTORY
COPY setup-virtualenv-with-spaces.sh /root
RUN /root/setup-virtualenv-with-spaces.sh