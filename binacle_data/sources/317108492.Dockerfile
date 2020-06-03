# Copyright 2018 AT&T Intellectual Property.  All other rights reserved.
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

ARG FROM=opensuse/leap:15.0
FROM ${FROM}

LABEL org.opencontainers.image.authors='airship-discuss@lists.airshipit.org, irc://#airshipit@freenode'
LABEL org.opencontainers.image.url='https://airshipit.org'
LABEL org.opencontainers.image.documentation='https://airship-deckhand.readthedocs.org'
LABEL org.opencontainers.image.source='https://opendev.org/airship/deckhand'
LABEL org.opencontainers.image.vendor='The Airship Authors'
LABEL org.opencontainers.image.licenses='Apache-2.0'

ENV container docker
ENV PORT 9000

# Expose port 9000 for application
EXPOSE $PORT

RUN set -x && \
    zypper -q update -y && \
    zypper install -y --no-recommends \
    git \
    curl \
    netcat-openbsd \
    netcfg \
    python3 \
    python3-setuptools \
    python3-pip \
    python3-devel \
    python3-python-dateutil \
    python3-dbm \
    ca-certificates \
    gcc \
    gcc-c++ \
    make \
    libffi-devel \
    libopenssl-devel \
    libpqxx-devel \
    && python3 -m pip install -U pip \
    && zypper clean -a \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base

# Create deckhand user
RUN useradd -ms /bin/bash deckhand

# Clone the deckhand repository
COPY . /home/deckhand/

# Change permissions
RUN chown -R deckhand: /home/deckhand \
    && chmod +x /home/deckhand/entrypoint.sh

# Set work directory and install dependencies
WORKDIR /home/deckhand
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

# Set user to deckhand
USER deckhand

# Execute entrypoint
ENTRYPOINT ["/home/deckhand/entrypoint.sh"]

CMD ["server"]
