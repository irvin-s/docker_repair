# Copyright (c) 2018 The ZJU-SEL Authors.
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

FROM wadelee/capstan-pusher AS capstan-pusher

FROM p7hb/docker-spark:2.2.0

MAINTAINER The ZJU-SEL team

# enable source command
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV PATH /root/capstan:$PATH
WORKDIR /root/capstan

COPY --from=capstan-pusher capstan-pusher /root/capstan/capstan-pusher

COPY run_benchmark.sh /root/capstan/run_benchmark.sh 
ENTRYPOINT ["./run_benchmark.sh"]
