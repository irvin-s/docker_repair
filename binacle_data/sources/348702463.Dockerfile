# Copyright 2014 Google Inc.
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

FROM google/debian:wheezy
ENV DEBIAN_FRONTEND noninteractive

ENV VERTX_VERSION 2.1.4
ENV VERTX_HOME /opt/vertx
ENV DEPLOYMENTS_HOME /app

RUN apt-get -q update && \
  apt-get install --no-install-recommends -y -q ca-certificates curl openjdk-7-jre-headless && \
  apt-get clean && \
  rm /var/lib/apt/lists/*_*

RUN useradd -ms /bin/bash vertx
RUN mkdir -p ${VERTX_HOME} ${DEPLOYMENTS_HOME} /var/log/app_engine/custom_logs
RUN chown vertx:vertx ${VERTX_HOME} ${DEPLOYMENTS_HOME} /var/log/app_engine/custom_logs

USER vertx

RUN mkdir -p ${VERTX_HOME} && (curl -0L http://dl.bintray.com/vertx/downloads/vert.x-${VERTX_VERSION}.tar.gz | tar -C ${VERTX_HOME} --strip-components=1 -zx)
RUN sed -i "s,%t,/var/log/app_engine/custom_logs/,g" ${VERTX_HOME}/conf/logging.properties

WORKDIR ${DEPLOYMENTS_HOME}

EXPOSE 8080

ENV RUN_FILE server.js

CMD []
VOLUME ["/var/log/app_engine"] 
#ENTRYPOINT ["${VERTX_HOME}/bin/vertx", "${DEPLOYMENTS_HOME}/${RUN_FILE}"]
CMD ["${VERTX_HOME}/bin/vertx", "run", "${DEPLOYMENTS_HOME}/${RUN_FILE}"]
