# Copyright 2017, bwsoft management
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

FROM bw-sw-spark
ENV LANG=en_US.UTF-8

ADD . /processor

WORKDIR /processor

COPY ./docker-entrypoint.sh /
COPY ./log4j.properties /usr/lib/spark/conf/

ENV SPARK_CONF_DIR /usr/lib/spark/conf

RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
