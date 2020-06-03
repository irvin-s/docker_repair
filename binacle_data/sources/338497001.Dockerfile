# Copyright IBM Corporation 2017,2018
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM envoyproxy/envoy:latest
RUN apt-get update && apt-get install -y ca-certificates openssl iptables curl emacs nmap telnet

ENV ENVOY_USER envoyuser
ENV ENVOY_UID 1337
ENV HOME /root


RUN useradd -ms /bin/bash $ENVOY_USER -u $ENVOY_UID

WORKDIR $HOME
COPY set_iptables.sh $HOME
COPY run_envoy.sh $HOME
COPY envoy_config.json $HOME
RUN chmod a+x $HOME
RUN chmod a+r $HOME/envoy_config.json

# expose envoy's stasd port
EXPOSE 8001

CMD $HOME/run_envoy.sh $ENVOY_UID $ENVOY_USER
