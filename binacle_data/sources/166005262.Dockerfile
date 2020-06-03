# Copyright 2014 Josh 'blacktop' Maine
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM nginx

MAINTAINER blacktop, https://github.com/blacktop

RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    python-software-properties \
    python-setuptools \
    build-essential \
    supervisor \
    python-dev \
    python \
    git \
  easy_install pip \
  pip install uwsgi \
  pip install flask \
  mkdir -p /var/log/supervisor

# install our code
ADD . /home/docker/code/

# Configure Nginx
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /home/docker/code/nginx-app.conf /etc/nginx/sites-enabled/
RUN ln -s /home/docker/code/supervisor-app.conf /etc/supervisor/conf.d/

# run pip install
RUN pip install -r /home/docker/code/app/requirements.txt

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
