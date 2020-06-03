# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

# --- Stage1: Get and build Couchdb ---
FROM erlang:18-slim as ntr-couchdb-build
RUN apt-get -qq update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y apt-utils \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends \
  python \
  build-essential \
  apt-transport-https \
  gcc \
  g++ \
  libcurl4-openssl-dev \
  libicu-dev \
  libmozjs185-dev \
  make \
  libmozjs185-1.0 \
  libnspr4 libnspr4-0d libnspr4-dev \
  openssl \
  curl \
  ca-certificates \
  git \
  pkg-config \
  libicu52 \
  procps

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y nodejs \
  && npm set progress=false && npm install -g grunt-cli@1.2.0 \
  && mkdir -p /usr/src/couchdb

WORKDIR /usr/src/couchdb

# get couchdb source
RUN git clone https://github.com/neutrinity/couchdb . \
  && git checkout 350f5919685c82e821bb69110fd21fa4d7e101b9

# compile and install couchdb
RUN ./configure -c --disable-docs \
  && make release
# -> Used Artifacts: /usr/src/couchdb/rel/couchdb


# --- Stage2: Build Final CouchDB Image ---
FROM erlang:18-slim as ntr-couch-clouseau
ENV COUCHDB_PATH /opt/couchdb

# finish couchdb
RUN groupadd -r couchdb && useradd -d "$COUCHDB_PATH" -g couchdb couchdb
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/backports.list
RUN apt-get -qq update -y \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y apt-utils \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends \
  libnspr4 libnspr4-0d \
  openssl \
  libicu52 \
  procps \
  libmozjs185-dev \
  libmozjs185-1.0 \
  # needed for cluster setup & testing
  curl \
  jq \
  # needed to run couchdb
  gosu \
  && rm -rf /var/lib/apt/lists/*

COPY --from=ntr-couchdb-build /usr/src/couchdb/rel/couchdb "$COUCHDB_PATH"
RUN ls -l "$COUCHDB_PATH" && chown -R couchdb:couchdb "$COUCHDB_PATH"

WORKDIR $COUCHDB_PATH

#COPY ./couchdb/local.ini "$COUCHDB_PATH/etc/local.d/10-docker-default.ini"
COPY ./couchdb/vm.args "$COUCHDB_PATH/etc/"

RUN mkdir "$COUCHDB_PATH/data"
VOLUME ["$COUCHDB_PATH/data"]

EXPOSE 5984 4369 9100

COPY ./couchdb/docker-entrypoint.sh $COUCHDB_PATH

# Setup directories and permissions
RUN chmod +x docker-entrypoint.sh \
 && chown -R couchdb:couchdb "$COUCHDB_PATH"

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["/opt/couchdb/bin/couchdb"]
