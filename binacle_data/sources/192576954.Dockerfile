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

FROM solinea/postgres:9.4

MAINTAINER Luke Heidecke <luke@solinea.com>

# GOLDSTONE_PASSWORD=goldstone      password for the 'goldstone' user in postgres
# POSTGRES_PASSWORD=goldstone       password for the 'postgres' user in postgres
ENV GOLDSTONE_PASSWORD="goldstone" \
    POSTGRES_PASSWORD="goldstone"

COPY init-goldstone-db.sh /docker-entrypoint-initdb.d/

COPY startup-goldstone-db.sh /docker-entrypoint-always.d/

EXPOSE 5432
