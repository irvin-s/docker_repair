##
# Copyright 2014-2016 Blue Snowman
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
##

FROM centos:centos7

MAINTAINER Blue Snowman

# https://webtatic.com/packages/php70/
RUN rpm -Uvhi https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum update -y

RUN yum install -y yum-utils
RUN yum-config-manager --enable cr

RUN yum install -y mc vim git

RUN yum install -y nginx
RUN yum install -y php70w-fpm php70w-common php70w-mbstring

RUN echo "date.timezone=America/New_York" >> /etc/php.ini

COPY ./classes /usr/share/nginx/classes
COPY ./setup/nginx.saber.conf /etc/nginx/default.d/

EXPOSE 80
