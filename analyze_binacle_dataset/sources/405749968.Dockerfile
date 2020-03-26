# Copyright (c) 2018 Intel Corporation
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


FROM centos:7 AS build

RUN yum -y groupinstall 'Development Tools'
RUN git clone https://github.com/twitter/twemcache
WORKDIR twemcache
RUN curl -s -o musl-1.1.19.tar.gz https://www.musl-libc.org/releases/musl-1.1.19.tar.gz
RUN tar -xf musl-1.1.19.tar.gz
WORKDIR musl-1.1.19
RUN ./configure
RUN make -j
RUN make install
WORKDIR /twemcache
RUN curl -L -s -o libevent-2.1.8-stable.tar.gz https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
RUN tar -zxf libevent-2.1.8-stable.tar.gz
WORKDIR libevent-2.1.8-stable
RUN ./configure CC=/usr/local/musl/bin/musl-gcc --enable-static --disable-shared
RUN make -j
RUN make install
WORKDIR /twemcache
RUN autoreconf -fvi
RUN CFLAGS="-ggdb3 -O2" ./configure CC=/usr/local/musl/bin/musl-gcc --enable-static
RUN make -j
RUN make install


FROM centos:7

COPY --from=build /usr/local/bin/twemcache /usr/local/bin/twemcache
COPY --from=build /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
RUN useradd -M twemcache
USER twemcache

CMD twemcache --prealloc --hash-power=20 --max-memory=1024 --port=${PORT} --eviction-strategy=2 --verbosity=4 --klog-file=/tmp/log-twemcache.cmd --threads=1 --backlog=128
