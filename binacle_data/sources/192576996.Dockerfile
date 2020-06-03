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

FROM solinea/elasticsearch:1.7.1

MAINTAINER Luke Heidecke <luke@solinea.com>

# Install admin plugins
RUN plugin install mobz/elasticsearch-head \
  && plugin -install royrusso/elasticsearch-HQ

ENV ES_CLUSTERNAME="goldstone" \
    ES_HEAP_SIZE="1g"

ENV ES_JAVA_OPTS="\
      -Des.cluster.name=goldstone \
      -Des.node.name=\${HOSTNAME} \
      -Des.index.search.slowlog.threshold.query.warn=10s \
      -Des.index.search.slowlog.threshold.query.info=5s \
      -Des.index.search.slowlog.threshold.query.debug=2s \
      -Des.index.search.slowlog.threshold.query.trace=500ms \
      -Des.index.search.slowlog.threshold.fetch.warn=1s \
      -Des.index.search.slowlog.threshold.fetch.info=800ms \
      -Des.index.search.slowlog.threshold.fetch.debug=500ms \
      -Des.index.search.slowlog.threshold.fetch.trace=200ms \
      -Des.index.indexing.slowlog.threshold.index.warn=10s \
      -Des.index.indexing.slowlog.threshold.index.info=5s \
      -Des.index.indexing.slowlog.threshold.index.debug=2s \
      -Des.index.indexing.slowlog.threshold.index.trace=500ms \
      -Des.monitor.jvm.gc.young.warn=1000ms \
      -Des.monitor.jvm.gc.young.info=700ms \
      -Des.monitor.jvm.gc.young.debug=400ms \
      -Des.monitor.jvm.gc.old.warn=10s \
      -Des.monitor.jvm.gc.old.info=5s \
      -Des.monitor.jvm.gc.old.debug=2s \
      "

# Overlays any files/directories to the ES config dir
COPY config /usr/share/elasticsearch/config

EXPOSE 9200 9300
