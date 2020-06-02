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

FROM solinea/goldstone-base:1.1.3

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

COPY goldstone-server/ ${APPDIR}/

COPY docker-entrypoint.sh /
