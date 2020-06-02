# Copyright 2015 Solinea, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM nginx

MAINTAINER Luke Heidecke <luke@solinea.com>

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

RUN preReqs=' \
    curl \
  ' \
  && apt-get update -y -q -q \
  && apt-get install -y -q $preReqs \
  && apt-get remove -y $buildReqs \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN openssl req -x509 -sha256 -newkey rsa:2048 \
  -keyout /etc/ssl/private/gsweb.pem \
  -out /etc/ssl/certs/gsweb.pem \
  -days 3650 -nodes \
  -subj '/C=US/ST=California/O=Solinea/OU=Goldstone/CN=gsweb' 

COPY config/nginx.conf /etc/nginx/nginx.conf

COPY config/conf.d /etc/nginx/conf.d

COPY static /usr/share/nginx/html/static

EXPOSE 8443
