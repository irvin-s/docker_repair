# Copyright 2014 Joukou Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM quay.io/joukou/java
MAINTAINER Isaac Johnston <isaac.johnston@joukou.com>

ENV DEBIAN_FRONTEND noninteractive

ENV RIAK_VERSION 2.0.1

ENV RIAK_LOG_CONSOLE console
ENV RIAK_LOG_CONSOLE_LEVEL warn
ENV RIAK_LOG_CRASH on
ENV RIAK_LOG_CRASH_MAXIMUM_MESSAGE_SIZE 64KB
ENV RIAK_LOG_CRASH_SIZE 10MB
ENV RIAK_LOG_CRASH_ROTATION $D0
ENV RIAK_LOG_CRASH_ROTATION_KEEP 5
ENV RIAK_NODENAME riak@127.0.0.1
ENV RIAK_DISTRIBUTED_COOKIE riak
ENV RIAK_ERLANG_ASYNC_THREADS 64
ENV RIAK_ERLANG_MAX_PORTS 65536
ENV RIAK_ERLANG_SCHEDULERS_FORCE_WAKEUP_INTERVAL 500
ENV RIAK_ERLANG_SCHEDULERS_COMPACTION_OF_LOAD true
ENV RIAK_ERLANG_SCHEDULERS_UTILIZATION_BALANCING false
ENV RIAK_RING_SIZE 64
ENV RIAK_TRANSFER_LIMIT 2
ENV RIAK_STRONG_CONSISTENCY on
ENV RIAK_PROTOBUF_BACKLOG 128
ENV RIAK_ANTI_ENTROPY active
ENV RIAK_STORAGE_BACKEND leveldb
ENV RIAK_OBJECT_FORMAT 1
ENV RIAK_OBJECT_SIZE_WARNING_THRESHOLD 5MB
ENV RIAK_OBJECT_SIZE_MAXIMUM 50MB
ENV RIAK_OBJECT_SIBLINGS_WARNING_THRESHOLD 25
ENV RIAK_OBJECT_SIBLINGS_MAXIMUM 100
ENV RIAK_CONTROL on
ENV RIAK_CONTROL_AUTH_MODE off
ENV RIAK_CONTROL_AUTH_USER_ADMIN_PASSWORD pass
ENV RIAK_LEVELDB_MAXIMUM_MEMORY_PERCENT 70
ENV RIAK_SEARCH on
ENV RIAK_SOLR_START_TIMEOUT 30s
ENV RIAK_SOLR_JVM_OPTIONS -d64 -Xms1g -Xmx1g -XX:+UseCompressedOops
ENV RIAK_ERLANG_DISTRIBUTION_PORT_RANGE_MINIMUM 8088
ENV RIAK_ERLANG_DISTRIBUTION_PORT_RANGE_MAXIMUM 8092
ENV RIAK_JAVASCRIPT_MAXIMUM_STACK_SIZE 32MB
ENV RIAK_JAVASCRIPT_MAXIMUM_HEAP_SIZE 16MB
ENV RIAK_JAVASCRIPT_HOOK_POOL_SIZE 4
ENV RIAK_JAVASCRIPT_REDUCE_POOL_SIZE 6
ENV RIAK_JAVASCRIPT_MAP_POOL_SIZE 8

# Install Basho Riak
WORKDIR /tmp
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends logrotate && \
    curl -LO http://s3.amazonaws.com/downloads.basho.com/riak/2.0/${RIAK_VERSION}/ubuntu/trusty/riak_${RIAK_VERSION}-1_amd64.deb && \
    dpkg -i riak_${RIAK_VERSION}-1_amd64.deb && \
    rm -f /etc/riak/riak.conf && \
    mkdir -p /var/lib/riak/js && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add Basho Riak configuration
ADD etc/riak/riak.conf.envsubst /etc/riak/
ADD etc/riak/riak.conf.tmpl /etc/riak/

# Add Lo-Dash
ADD https://raw.githubusercontent.com/lodash/lodash/2.4.1/dist/lodash.compat.js /var/lib/riak/js/

# Make Riak's data and log directories volumes
VOLUME [ "/var/lib/riak", "/var/log/riak" ]

# Expose ports
#   4370        Erlang Port Mapper Daemon (epmd)
#   8087        Protocol Buffers API
#   8088-8092   Erlang Distributed Node Protocol
#   8093        Solr
#   8098        HTTP API
#   8099        Intra-Cluster Handoff
#   8985        Solr JMX
EXPOSE 4370 8087 8088 8089 8090 8091 8092 8093 8098 8099 8985

# Add boot script
ADD bin/boot /bin/
CMD [ "/bin/boot" ]
