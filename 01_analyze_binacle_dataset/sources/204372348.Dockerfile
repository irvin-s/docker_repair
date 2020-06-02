# docker-pureftpd
# Copyright (C) 2016  gimoh
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

FROM gimoh/pureftpd
MAINTAINER gimoh <gimoh@bitmessage.ch>

# Python 3 and pip installation based on:
# https://hub.docker.com/r/frolvlad/alpine-python3/

RUN apk add --update python3=3.5.1-r0 \
    && python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && pip3 install boto3==1.2.3 docopt==0.6.2 shell.py==0.5.3 \
    && rm -rf /root/.cache /usr/lib/python*/ensurepip /var/cache/apk/*

COPY dkr-init.sh /usr/local/sbin/dkr-init
COPY auto-users.py /usr/local/bin/auto-users
