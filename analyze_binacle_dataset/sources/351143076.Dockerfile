# ----------------------------------------------------------------------
# Copyright (C) 2016-2017, Numenta, Inc.  Unless you have purchased from
# Numenta, Inc. a separate commercial license for this software code, the
# following terms and conditions apply:
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Affero Public License for more details.
#
# You should have received a copy of the GNU Affero Public License
# along with this program.  If not, see http://www.gnu.org/licenses.
#
# http://numenta.org/licenses/
# ----------------------------------------------------------------------

FROM ubuntu:14.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       build-essential \
                       libmysqlclient-dev \
                       libffi-dev \
                       libssl-dev \
                       nginx \
                       python2.7 \
                       python2.7-dev \
                       python-software-properties \
                       software-properties-common \
                       wget

RUN wget http://releases.numenta.org/pip/1ebd3cb7a5a3073058d0c9552ab074bd/get-pip.py -O - | python
RUN pip install --upgrade setuptools wheel

# Copy taurus-relevant numenta-apps subdirs to image
COPY nta.utils /opt/numenta/nta.utils
COPY htmengine /opt/numenta/htmengine
COPY taurus_engine /opt/numenta/taurus_engine
COPY install-taurus.sh /opt/numenta/

# OPF needs this
ENV USER docker

# Install taurus
WORKDIR /opt/numenta
RUN ./install-taurus.sh

# Environment
ENV APPLICATION_CONFIG_PATH=/opt/numenta/taurus_engine/conf \
    MYSQL_HOST=mysql \
    MYSQL_USER=root \
    MYSQL_PASSWD="" \
    RABBITMQ_HOST=rabbit \
    RABBITMQ_USER=guest \
    RABBITMQ_PASSWD=guest \
    TAURUS_RMQ_METRIC_DEST=rabbit \
    TAURUS_RMQ_METRIC_PREFIX=CHANGEME \
    DYNAMODB_TABLE_SUFFIX=CHANGEME \
    DYNAMODB_HOST="" \
    DYNAMODB_PORT="" \
    TAURUS_API_KEY=CHANGEME \
    TAURUS_SERVER_HOST=CHANGEME \
    SSL_ORG_NAME=Numenta \
    SSL_LOCALITY=CA \
    SSL_DOMAIN_NAME=localhost \
    SSL_ORGANIZATIONAL_UNIT_NAME=Engineering \
    SSL_EMAIL_ADDRESS=support@numenta.com \
    AWS_ACCESS_KEY_ID=CHANGEME \
    AWS_SECRET_ACCESS_KEY=CHANGEME \
    OBLITERATE_DATABASE=""

ENTRYPOINT ["/opt/numenta/taurus_engine/docker/entrypoint.sh"]
CMD ["/opt/numenta/taurus_engine/docker/run.sh"]
VOLUME ["/opt/numenta/taurus_engine/logs", \
        "/root/taurus_model_checkpoints"]
