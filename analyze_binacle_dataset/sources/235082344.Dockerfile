# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM node:6

RUN useradd -m moonlight
RUN apt-get -qq update && \
    apt-get -qq install -y strace libnss3

WORKDIR /home/moonlight
ENV NPM_CONFIG_LOGLEVEL=error \
    NODE_ENV=production
RUN npm install googlechrome/lighthouse#7f5aaaa9

ADD bin/headless-shell.tar.gz bin/
ADD bin/server bin/
RUN chmod 644 bin/* && \
    chmod 755 bin/server bin/headless_shell

USER moonlight
EXPOSE 8080
ENTRYPOINT ["/home/moonlight/bin/server"]
