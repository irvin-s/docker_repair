##############################################################################
# Copyright (c) 2015 Ericsson AB and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

FROM ubuntu:14.04
MAINTAINER Dimitri Mazmanov <dimitri.mazmanov@ericsson.com>

COPY . /tmp/elkstack

RUN echo 'sudo service logstash start' >> /tmp/elkstack/start.sh
RUN echo 'sudo service elasticsearch start' >> /tmp/elkstack/start.sh
RUN echo 'sudo service kibana start' >> /tmp/elkstack/start.sh

RUN cd /tmp/elkstack && /bin/bash /tmp/elkstack/elkstack.sh

EXPOSE 80
EXPOSE 22
EXPOSE 9200
EXPOSE 5044

ENV HOME /home/elkstack
WORKDIR /home/elkstack

CMD bash -C '/tmp/elkstack/start.sh';'bash'
