# Copyright (c) 2016-2018, F5 Networks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

From test_base:latest

COPY ./f5-openstack-agent/ /root/devenv/f5-openstack-agent/
RUN pip install --upgrade /root/devenv/f5-openstack-agent
WORKDIR /root/devenv/f5-openstack-agent/test/functional/neutronless/l2adjacent
RUN py.test -v --symbols conf_symbols.json ./

