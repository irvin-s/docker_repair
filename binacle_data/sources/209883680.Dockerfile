FROM jfloff/alpine-python:2.7

# for a flask server
ADD . /gcdt
RUN ls -l gcdt
ADD pip.conf /root/.pip/pip.conf
RUN pip install pip-tools
RUN echo 'gcdt { slack-token=""}' >> /root/.gcdt
WORKDIR /gcdt
RUN ls -l
RUN pip install -U pip==8.1.1
RUN pip-compile
RUN pip-sync
RUN python setup.py install
RUN kumo version && ramuda version && tenkai version && yugen version
