# Cerebro Secret Sniffing
# This tool finds secrets such as passwords, tokens, private keys and
# more in a Git repositories or list of Git repositories.

# Copyright (C) 2017 Twilio Inc.

# Cerebro is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version. Cerebro is distributed in the
# hope that it will be useful, but WITHOUT ANY WARRANTY; without even
# the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with Cerebro; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

FROM ubuntu:latest

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN apt-get update
RUN apt-get install -y ca-certificates
RUN apt-get install -y git

# application folder
ENV APP_DIR /app

# app dir
ADD . ${APP_DIR}
WORKDIR ${APP_DIR}
RUN pip install -r requirements.txt
