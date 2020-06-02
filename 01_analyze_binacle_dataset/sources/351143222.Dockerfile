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
                       python2.7 \
                       python2.7-dev \
                       python-software-properties \
                       software-properties-common \
                       wget

RUN wget http://releases.numenta.org/pip/1ebd3cb7a5a3073058d0c9552ab074bd/get-pip.py -O - | python
RUN pip install --upgrade setuptools wheel

# Copy taurus_metric_collectors-relevant numenta-apps subdirs to image
COPY nta.utils /opt/numenta/nta.utils
COPY htmengine /opt/numenta/htmengine
COPY taurus_metric_collectors /opt/numenta/taurus_metric_collectors
COPY install-taurus-metric-collectors.sh /opt/numenta/

# Install taurus_metric_collectors
WORKDIR /opt/numenta
RUN ./install-taurus-metric-collectors.sh

# Environment
ENV APPLICATION_CONFIG_PATH=/opt/numenta/taurus_metric_collectors/conf \
    MYSQL_HOST=mysql \
    MYSQL_USER=root \
    MYSQL_PASSWD="" \
    RABBITMQ_HOST=rabbit \
    RABBITMQ_USER=guest \
    RABBITMQ_PASSWD=guest \
    TAURUS_HTM_SERVER=CHANGEME \
    TAURUS_API_KEY=CHANGEME \
    XIGNITE_API_TOKEN=CHANGEME \
    TAURUS_TWITTER_ACCESS_TOKEN=CHANGEME \
    TAURUS_TWITTER_ACCESS_TOKEN_SECRET=CHANGEME \
    TAURUS_TWITTER_CONSUMER_KEY=CHANGEME \
    TAURUS_TWITTER_CONSUMER_SECRET=CHANGEME \
    ERROR_REPORT_EMAIL_AWS_REGION=CHANGEME \
    ERROR_REPORT_EMAIL_RECIPIENTS=CHANGEME \
    ERROR_REPORT_EMAIL_SENDER_ADDRESS=CHANGEME \
    ERROR_REPORT_EMAIL_SES_ENDPOINT=CHANGEME \
    AWS_ACCESS_KEY_ID=CHANGEME \
    AWS_SECRET_ACCESS_KEY=CHANGEME \
    OBLITERATE_DATABASE=""

ENTRYPOINT ["/opt/numenta/taurus_metric_collectors/docker/entrypoint.sh"]
CMD ["/opt/numenta/taurus_metric_collectors/docker/run.sh"]
VOLUME ["/opt/numenta/taurus_metric_collectors/logs"]
