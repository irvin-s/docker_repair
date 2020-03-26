# ----------------------------------------------------------------------
# Copyright (C) 2017, Numenta, Inc.  Unless you have purchased from
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

# OS-level dependencies
RUN apt-get update && \
    apt-get -y install apt-transport-https \
                       build-essential \
                       libffi-dev \
                       libmysqlclient-dev \
                       libssl-dev \
                       python2.7 \
                       python2.7-dev \
                       python-software-properties \
                       software-properties-common \
                       wget

RUN wget http://releases.numenta.org/pip/1ebd3cb7a5a3073058d0c9552ab074bd/get-pip.py -O - | python
RUN pip install --upgrade setuptools wheel

COPY nta.utils /opt/numenta/nta.utils
COPY htmengine /opt/numenta/htmengine
COPY taurus_engine /opt/numenta/taurus_engine
COPY taurus_monitoring /opt/numenta/taurus_monitoring
COPY install-taurus-monitoring.sh /opt/numenta/

# Install taurus monitoring
WORKDIR /opt/numenta
RUN ./install-taurus-monitoring.sh

ENTRYPOINT ["/opt/numenta/taurus_monitoring/docker/entrypoint.sh"]
