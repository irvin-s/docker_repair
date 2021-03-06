#   Copyright 2017 Karol Brejna
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
FROM python:3.6-alpine

ADD  . /

RUN    apk --no-cache add --virtual=.build-dep build-base git \
    && apk --no-cache add libzmq \
    && git clone https://github.com/locustio/locust.git \
    && cd locust \
    && git checkout 4bc679c8dce645aca2c92ce3ed7f5c3c17c29d1d \
    && git apply ../handler.diff \
    && cd .. \
    && pip install --no-cache-dir ./locust \
    && apk del .build-dep \
    && chmod +x /docker-entrypoint.sh \
    && rm -rf locust

RUN  mkdir /locust
WORKDIR /locust
EXPOSE 8089 5557 5558

ENTRYPOINT ["/docker-entrypoint.sh"]