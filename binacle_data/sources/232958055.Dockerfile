#
# Copyright (C) 2015 The Gravitee team (http://gravitee.io)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM graviteeio/java:8
MAINTAINER Gravitee Team <http://gravitee.io>

ARG GRAVITEEAM_VERSION=0
ENV GRAVITEEAM_HOME /opt/graviteeio-am-gateway

# Update to get support for Zip/Unzip, nc and wget
RUN apk add --update zip unzip netcat-openbsd wget

RUN wget --no-check-certificate -O /tmp/gravitee-am-gateway-standalone-${GRAVITEEAM_VERSION}.zip https://oss.sonatype.org/service/local/artifact/maven/content\?r\=snapshots\&g\=io.gravitee.am.gateway.standalone\&a\=gravitee-am-gateway-standalone-distribution-zip\&p\=zip\&v\=${GRAVITEEAM_VERSION} \
    && unzip /tmp/gravitee-am-gateway-standalone-${GRAVITEEAM_VERSION}.zip -d /tmp/ \
    && mv /tmp/gravitee-am-gateway-standalone-${GRAVITEEAM_VERSION} /opt/graviteeio-am-gateway \
    && rm -rf /tmp/*

RUN addgroup -g 1000 gravitee \
    && adduser -D -u 1000 -G gravitee -h ${GRAVITEEAM_HOME} gravitee \
    && chown -R gravitee:gravitee ${GRAVITEEAM_HOME}

USER 1000

WORKDIR ${GRAVITEEAM_HOME}

EXPOSE 8092
VOLUME ["/opt/gravitee-am-gateway/logs"]
CMD ["./bin/gravitee"]