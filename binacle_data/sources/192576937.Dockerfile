# vim:set ft=dockerfile:
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

FROM solinea/gunicorn:19.3.0

MAINTAINER Luke Heidecke <luke@solinea.com>

# DJANGO_ADMIN_EMAIL                email address for admininstrative emails
# DJANGO_ADMIN_PASSWORD             password for 'admin' user in goldstone client
# GOLDSTONE_PASSWORD=goldstone      password for the 'goldstone' user in postgres
# GOLDSTONE_TENANT_ADMIN_PASSWORD   password for 'gsadmin' user in goldstone client
# OS_AUTH_URL                       OpenStack authentication url
# OS_TENANT_NAME                    OpenStack tenant name
# OS_USERNAME                       OpenStack user name (usually admin)
# OS_PASSWORD                       OpenStack user's password
# POSTGRES_PASSWORD=goldstone       password for the 'postgres' user in postgres
ENV DJANGO_ADMIN_EMAIL="root@localhost" \
    DJANGO_ADMIN_PASSWORD="goldstone" \
    GOLDSTONE_PASSWORD="goldstone" \
    GOLDSTONE_TENANT_ADMIN_PASSWORD="goldstone" \
    POSTGRES_PASSWORD="goldstone"

# Not to be modified unless directed
ENV DJANGO_SETTINGS_MODULE=goldstone.settings.docker \
    DJANGO_ADMIN_USER=admin \
    GOLDSTONE_REDIS_HOST=gstaskq \
    CELERY_LOGLEVEL=info

WORKDIR ${APPDIR}

USER root

RUN buildReqs=' \
    python2.7-dev \
    gcc \
    g++ \
  ' \
  && preReqs=' \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    git \
  ' \
  && apt-get update -y -q -q \
  && apt-get install -y -q $buildReqs \
  && apt-get install -y -q $preReqs \
  && mkdir -p /usr/share/nginx/html/static \
  && chown -R ${APPUSER}:staff /usr/share/nginx/html/static \
  && chown -R ${APPUSER}:staff ${APPDIR} 

USER ${APPUSER}

COPY config ${APPDIR}/config

USER root

# purposely creating a new layer for the requirements.
RUN su - ${APPUSER} -c ". /venv/bin/activate && pip install -r ${APPDIR}/config/requirements.txt" \
  && apt-get remove -y $buildReqs \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ${APPUSER}

COPY docker-entrypoint.sh /

EXPOSE 8000

ENTRYPOINT ["/docker-entrypoint.sh"]
